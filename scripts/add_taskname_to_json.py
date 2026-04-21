#!/usr/bin/env python3
"""
Add missing TaskName to functional task JSON sidecars.
Usage: python3 add_taskname_to_jsons.py /path/to/bids
"""

import json
import re
from pathlib import Path
import sys

def extract_task_from_filename(filename):
    """Extract task name from BIDS filename (e.g., task-emt from ...task-emt_...)"""
    match = re.search(r'task-([a-zA-Z0-9]+)', filename)
    if match:
        return match.group(1)
    return None

def process_json_sidecars(bids_root):
    """Add TaskName to all functional JSON sidecars"""
    bids_path = Path(bids_root)
    
    if not bids_path.exists():
        print(f"Error: BIDS root not found: {bids_root}")
        return False
    
    # Find all functional JSON files
    json_files = list(bids_path.glob('**/func/*_bold.json'))
    
    if not json_files:
        print("No functional JSON files found.")
        return False
    
    print(f"Found {len(json_files)} functional JSON files")
    
    for json_file in json_files:
        # Read the JSON
        with open(json_file, 'r') as f:
            data = json.load(f)
        
        # Check if TaskName is missing
        if 'TaskName' not in data:
            task_name = extract_task_from_filename(json_file.name)
            
            if task_name:
                data['TaskName'] = task_name
                
                # Write back the updated JSON
                with open(json_file, 'w') as f:
                    json.dump(data, f, indent=2)
                
                print(f"✓ Added TaskName='{task_name}' to {json_file.relative_to(bids_path)}")
            else:
                print(f"✗ Could not extract task name from {json_file.name}")
        else:
            print(f"✓ TaskName already exists in {json_file.relative_to(bids_path)}")
    
    return True

if __name__ == '__main__':
    bids_root = sys.argv[1] if len(sys.argv) > 1 else '.'
    success = process_json_sidecars(bids_root)
    sys.exit(0 if success else 1)