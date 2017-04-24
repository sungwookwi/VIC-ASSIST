hFigure = findall(0,'Name','umass_vic_assist');
set(hFigure,'PaperPositionMode','auto', 'InvertHardCopy', 'off')
print(hFigure,'-dpng','-r600','.\FIGURE_VIC_ASSIST')


