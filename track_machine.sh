#!/bin/bash

# Usage: ./track_machine.sh <IP> <MachineName> <Points> <Difficulty>
# Example: ./track_machine.sh 10.10.10.10 Arctic 20 Easy

if [ "$#" -ne 4 ]; then
    echo "Usage: $0 <IP> <MachineName> <Points> <Difficulty>"
    exit 1
fi

IP=$1
NAME=$2
POINTS=$3
DIFFICULTY=$4
DATE=$(date +%Y-%m-%d)

BASE_DIR=~/HTB/$NAME
mkdir -p "$BASE_DIR"

# Run nmap scan
nmap -sC -sV -oN "$BASE_DIR/nmap_scan.txt" "$IP"

# Create Markdown report template
REPORT="$BASE_DIR/report.md"
echo "# HTB Report: $NAME" > "$REPORT"
echo "**IP:** $IP" >> "$REPORT"
echo "**Difficulty:** $DIFFICULTY" >> "$REPORT"
echo "**Points:** $POINTS" >> "$REPORT"
echo "**Date Completed:** $DATE" >> "$REPORT"
echo "\n## Enumeration" >> "$REPORT"
echo "\n## Exploitation" >> "$REPORT"
echo "\n## Post Exploitation" >> "$REPORT"
echo "\n## Notes" >> "$REPORT"

echo "Report template created at $REPORT"

# Update CSV log
CSV=~/HTB/htb_progress.csv
if [ ! -f "$CSV" ]; then
    echo "Machine,IP,Difficulty,Points,DateCompleted" > "$CSV"
fi
echo "$NAME,$IP,$DIFFICULTY,$POINTS,$DATE" >> "$CSV"
echo "CSV log updated at $CSV"

# Generate graph automatically
~/HackTheBox-Progress-Tracker-Kali/generate_htb_graph.py

echo "HTB machine tracking for $NAME completed."

