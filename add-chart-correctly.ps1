# Add ONLY the chart to the existing math section - no duplicates

$filePath = "marketing\county-cap.html"
$backupPath = "marketing\county-cap.html.final-backup"

Write-Host "Reading file..."
$content = Get-Content $filePath -Encoding UTF8 -Raw

# Create backup
Write-Host "Creating backup..."
Copy-Item $filePath $backupPath

# Chart canvas HTML - just the chart, nothing else
$chartHTML = @"
                <!-- INTERACTIVE CHART -->
                <div class="chart-container">
                    <canvas id="capacityChart"></canvas>
                </div>
                
"@

# Chart.js initialization script
$chartScript = @"
        <script>
            document.addEventListener('DOMContentLoaded', function() {
                const ctx = document.getElementById('capacityChart');
                if (ctx) {
                    new Chart(ctx, {
                        type: 'line',
                        data: {
                            labels: ['10%', '20%', '33%', '50%', '100%'],
                            datasets: [{
                                label: 'Your Cases/Month',
                                data: [4.8, 4.2, 3.7, 3.2, 2.5],
                                borderColor: '#0A2463',
                                backgroundColor: 'rgba(10, 36, 99, 0.1)',
                                tension: 0.4,
                                fill: true
                            }, {
                                label: 'Baseline (No TrueVow)',
                                data: [2.5, 2.5, 2.5, 2.5, 2.5],
                                borderColor: '#C62828',
                                borderDash: [5, 5],
                                backgroundColor: 'rgba(198, 40, 40, 0.1)',
                                fill: true
                            }]
                        },
                        options: {
                            responsive: true,
                            maintainAspectRatio: true,
                            plugins: {
                                title: {
                                    display: true,
                                    text: 'Market Penetration vs. Your Competitive Advantage',
                                    font: { size: 18, weight: 'bold' }
                                },
                                legend: { display: true, position: 'top' }
                            },
                            scales: {
                                y: {
                                    beginAtZero: true,
                                    max: 5,
                                    title: { display: true, text: 'Cases per Month' }
                                },
                                x: {
                                    title: { display: true, text: 'Market Penetration' }
                                }
                            }
                        }
                    });
                }
            });
        </script>
"@

# Check if chart already exists
if ($content -match 'capacityChart') {
    Write-Host "Chart already exists - skipping"
} else {
    Write-Host "Adding chart to existing math section..."
    
    # Find "Math Behind" then find the section-content div after it
    $mathPos = $content.IndexOf('Math Behind')
    if ($mathPos -gt 0) {
        # Look for section-content div after "Math Behind"
        $afterMath = $content.Substring($mathPos)
        $sectionContentStart = $afterMath.IndexOf('class="section-content"')
        
        if ($sectionContentStart -gt 0) {
            # Find the closing > of the div tag
            $divEnd = $afterMath.IndexOf('>', $sectionContentStart) + 1
            $insertionPoint = $mathPos + $sectionContentStart + $divEnd
            
            # Insert chart HTML right after opening section-content div
            $content = $content.Insert($insertionPoint, "`n$chartHTML")
            Write-Host "Chart canvas added to existing math section"
        } else {
            Write-Host "Could not find section-content div"
        }
    } else {
        Write-Host "Could not find Math Behind section"
    }
}

# Add chart script if not already there
if ($content -notmatch 'new Chart.*capacityChart') {
    $bodyEnd = $content.LastIndexOf('</body>')
    if ($bodyEnd -gt 0) {
        $content = $content.Insert($bodyEnd, $chartScript)
        Write-Host "Chart script added"
    }
} else {
    Write-Host "Chart script already exists"
}

# Save with UTF-8 encoding
$utf8NoBom = New-Object System.Text.UTF8Encoding $false
[System.IO.File]::WriteAllText($filePath, $content, $utf8NoBom)

Write-Host "Done! Chart added to existing section only."
Write-Host "Backup: $backupPath"

