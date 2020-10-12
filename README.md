# Mätdata - Experimentell Fysik
Källkod och mätdata från laboration 3, Kopplade Svängningar.

## Innehåll
Mätdatan och koden är sorterad i olika mappar för att underlätta hantering och sökning i datan.

### CSV Data
I denna mapp och dess undermappar finns .tsv-filerna från ``Unprocessed Data`` konverterade till .csv med metadata om kolumnerna borttaget. Dessa gjordes för att underlätta importering av data till MATLAB.

### src
I denna mapp finns all källkod till alla MATLAB-scripts som användes för analys av datan och för att skapa figurerna till rapporten. Dessutom ligger ``convert.py`` här vilket är ett script som konverterar .tsv till .csv.

### Unprocessed Data
Under denna mapp finns .tsv-filer exporterade från *Qualisys Track Manager* utan ändringar. De är fördelade i undermappar efter vilken mätserie de tillhör (E-L) och två mappar med mätningar för origos förflyttelse respektive periodtider för uträkning av fjäderkonstanter.