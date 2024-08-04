@echo off
set RealityCaptureExe="C:\Program Files\Capturing Reality\RealityCapture\RealityCapture.exe"
set RootFolder=%cd%

set DetectMarkersParams="%RootFolder%\RC_params\DetectMarkersParams.xml"
set GCPCoordinates="%RootFolder%\RC_params\GCPDetectedMarkers_print.txt"
set ImportGCPParams="%RootFolder%\RC_params\GCPImportParams.xml"
set ReconstructionRegion="%RootFolder%\RC_params\ReconstructionRegion_print.rcbox"
set TextureParams="%RootFolder%\RC_params\TextureSettings.xml"

for /d %%D in ("%RootFolder%\*") do (
     if /i not "%%~nxD"=="RC_params" (
        echo Processing ScanFolder: %RootFolder%\%%~nxD

        %RealityCaptureExe% -newScene ^
            -stdConsole ^
            -clearCache ^
            -addFolder "%RootFolder%\%%~nxD" ^
            -detectMarkers "%DetectMarkersParams%" ^
            -importGroundControlPoints "%GCPCoordinates%" "%ImportGCPParams%" ^
            -set "sfmImagesOverlap=Low" ^
            -align ^
            -selectMaximalComponent ^
            -setReconstructionRegion %ReconstructionRegion% ^
            -calculateHighModel ^
            -selectLargestModelComponent ^
            -invertTrianglesSelection ^
            -selectMarginalTriangles  ^
            -removeSelectedTriangles  ^
            -closeHoles ^
            -cleanModel ^
            -set "txtImageDownscaleTexture=1" ^
            -set "txtImportDefaultTexResolution=16384" ^
            -set "unwrapMaxTexResolution=16384" ^
            -set "txtStyle=PhotoConsistencyBased" ^
            -set "txtImportDefaultTexResolution=PhotoConsistencyBased" ^
            -set "unwrapStyle=MaxTexturesCount" ^
            -set "unwrapMaximalTexCount=1" ^
            -calculateTexture ^
            -save "%RootFolder%\%%~nxD\%%~nxD_rcproject.rcproj"^
            -exportSelectedModel "%RootFolder%\%%~nxD.obj"^
            -quit^
            > process.log




    )
)


