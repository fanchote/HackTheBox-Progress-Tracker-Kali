#!/usr/bin/env python3

import csv
import matplotlib.pyplot as plt
from datetime import datetime
import os

csv_file = os.path.expanduser('~/HTB/htb_progress.csv')
dates = []
points = []
total = 0

with open(csv_file, 'r') as file:
    reader = csv.DictReader(file)
    data = sorted(reader, key=lambda x: datetime.strptime(x['DateCompleted'], '%Y-%m-%d'))
    for row in data:
        total += int(row['Points'])
        dates.append(datetime.strptime(row['DateCompleted'], '%Y-%m-%d'))
        points.append(total)

if not dates:
    print("No hay datos en el CSV para graficar.")
    exit()

plt.figure()
plt.plot(dates, points, marker='o')
plt.title('Progreso en HackTheBox (Kali Linux)')
plt.xlabel('Fecha de resolución')
plt.ylabel('Puntos acumulados')
plt.grid(True)
plt.tight_layout()
output_path = os.path.expanduser('~/HTB/htb_progress.png')
plt.savefig(output_path)
plt.show()
print("Grafica generada en", output_path)
