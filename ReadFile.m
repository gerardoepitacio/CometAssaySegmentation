function FullFileName = ReadFile()
Filter={'*.jpg;*.jpeg;*.png;*.tif;*.bmp'};
[FileName, FilePath]=uigetfile(Filter);
pause(0.01);
if FileName == 0
    FullFileName = 0;
end
FullFileName = [FilePath FileName];
