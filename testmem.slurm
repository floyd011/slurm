#!/bin/bash
#SBATCH --output=mem_kill_test.out
#SBATCH --error=mem_kill_test.err
#SBATCH --job-name=mem_kill_test
#SBATCH --ntasks=1
#SBATCH --mem=100M
#SBATCH --time=00:05:00
#SBATCH --partition=mypartition
#SBATCH --nodelist=node-0

echo "=== Pokrecem test memorije ==="

python3 - <<'EOF'
#!/usr/bin/env python3
import sys
import time

leak = []
total = 0
limit = 3 * 1024 * 1024 * 1024   # 3 GB limit

block = 50 * 1024 * 1024        # 50 MB po iteraciji

print("Pokrećem memory leak (limit 3GB)...")

while total < limit:
    leak.append(bytearray(block))
    total += block
    print(f"[LEAK] Alocirano ukupno: {total/1024/1024:.1f} MB")
    time.sleep(0.2) 

print(">>> Dostignut interni limit (3GB). Zaustavljam test.")
EOF

echo "=== Test zavrsen ==="
