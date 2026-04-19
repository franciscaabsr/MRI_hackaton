# skull-strip-check.R — Shiny app for visual QA of fMRIprep skull stripping
#
# Displays the fMRIprep T1w (desc-preproc_T1w) with the tissue segmentation
# (dseg) overlaid in red to verify skull stripping quality.
#
# The dseg labels are: 0 = background · 1 = CSF · 2 = GM · 3 = WM
# Setting min = 0.5 in the overlay hides background and shows all tissue
# classes as uniform red — effectively binarising the display.
#
# Usage
# -----
# Launch from an R session:
#   shiny::runApp("scripts/skull-strip-check.R", port = 3838)
#
# Or from the terminal (keeps running after SSH disconnect if in tmux/nohup):
#   Rscript -e "shiny::runApp('scripts/skull-strip-check.R', port=3838, host='0.0.0.0')"
#
# SSH tunnel (from your laptop):
#   ssh -L 3838:localhost:3838 yourname@storm
#   Then open http://localhost:3838

library(shiny)
library(shinyFiles)
library(DT)
library(dplyr)
library(stringr)
library(papayaWidget)

# ═══════════════════════════════════════════════════════════════════════════════
# Helpers
# ═══════════════════════════════════════════════════════════════════════════════

discover_subjects <- function(deriv_dir) {
  t1w_files <- list.files(
    deriv_dir,
    pattern    = "_desc-preproc_T1w\\.nii\\.gz$",
    recursive  = TRUE,
    full.names = TRUE
  )
  if (length(t1w_files) == 0) return(tibble())

  tibble(t1w = t1w_files) |>
    filter(!str_detect(basename(t1w), "space-")) |>   # keep native-space T1w only
    mutate(
      sub      = str_extract(basename(t1w), "sub-[^_]+"),
      ses      = coalesce(str_extract(basename(t1w), "ses-[^_]+"), "—"),
      # dseg is in native space alongside the T1w
      dseg     = str_replace(t1w, "_desc-preproc_T1w\\.nii\\.gz$", "_dseg.nii.gz"),
      has_dseg = file.exists(dseg)
    ) |>
    arrange(sub, ses)
}

# ═══════════════════════════════════════════════════════════════════════════════
# UI
# ═══════════════════════════════════════════════════════════════════════════════

ui <- fluidPage(

  titlePanel("Skull Strip QA"),

  tags$head(tags$style(HTML("
    .well { padding: 12px; }
    h5 { color: #495057; margin-top: 10px; margin-bottom: 4px; }
    .text-warning { color: #856404; font-weight: 500; }
  "))),

  fluidRow(

    # ── Left: discovery + subject table ───────────────────────────────────────
    column(3,
      wellPanel(
        h4("① Derivatives folder"),
        shinyDirButton("deriv_dir", "Browse server…",
                       title = "Select fmriprep derivatives folder"),
        br(),
        textOutput("deriv_dir_text"),
        hr(),
        h5("Subjects found"),
        tags$small("Click a row to load the viewer"),
        br(),
        DTOutput("subject_table")
      )
    ),

    # ── Right: papaya viewer ───────────────────────────────────────────────────
    column(9,
      wellPanel(
        h4("② Skull strip inspection"),
        tags$small(
          "T1w (greyscale) + tissue segmentation overlay (red, α = 0.5). ",
          "dseg labels: 0 = background · 1 = CSF · 2 = GM · 3 = WM — ",
          "all non-zero labels are displayed as solid red."
        ),
        br(), br(),
        uiOutput("viewer")
      )
    )

  )
)

# ═══════════════════════════════════════════════════════════════════════════════
# Server
# ═══════════════════════════════════════════════════════════════════════════════

server <- function(input, output, session) {

  volumes <- c(Root = "/")
  shinyDirChoose(input, "deriv_dir", roots = volumes, session = session)

  rv <- reactiveValues(
    deriv_path  = NULL,
    subjects_df = NULL
  )

  # ── Derivatives folder selected ────────────────────────────────────────────
  observeEvent(input$deriv_dir, {
    req(is.list(input$deriv_dir))
    rv$deriv_path <- parseDirPath(volumes, input$deriv_dir)
    withProgress(message = "Scanning for T1w and dseg files…", {
      rv$subjects_df <- discover_subjects(rv$deriv_path)
    })
  })

  output$deriv_dir_text <- renderText({
    if (is.null(rv$deriv_path)) "— not selected —" else rv$deriv_path
  })

  # ── Subject table ──────────────────────────────────────────────────────────
  output$subject_table <- renderDT({
    req(rv$subjects_df, nrow(rv$subjects_df) > 0)
    df <- rv$subjects_df |>
      transmute(
        Subject = sub,
        Session = ses,
        dseg    = ifelse(has_dseg, "✅", "⚠️ missing")
      )
    datatable(
      df,
      selection = list(mode = "single", selected = 1),
      options   = list(dom = "tp", pageLength = 30),
      rownames  = FALSE
    )
  })

  # ── Papaya viewer ──────────────────────────────────────────────────────────
  output$viewer <- renderUI({
    req(rv$subjects_df, nrow(rv$subjects_df) > 0)
    idx <- input$subject_table_rows_selected
    req(length(idx) > 0)

    row  <- rv$subjects_df[idx, ]
    t1w  <- row$t1w
    dseg <- row$dseg
    req(file.exists(t1w))

    if (file.exists(dseg)) {
      papaya(
        c(t1w, dseg),
        option = list(
          papayaOptions(alpha = 1,   lut = "Grayscale"),
          papayaOptions(alpha = 0.5, lut = "Overlay (Negatives)", min = 0.1, max = 0.15)
        ),
        interpolation = FALSE
      )
    } else {
      tagList(
        tags$p(class = "text-warning",
               "⚠️ No dseg file found for this subject — showing T1w only."),
        papaya(
          t1w,
          option = list(papayaOptions(alpha = 1, lut = "Grayscale")),
          interpolation = FALSE
        )
      )
    }
  })

}

shinyApp(ui, server)
