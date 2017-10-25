function checkSubmission(andrewid)
% checkSubmission verifies that your submission zip has the correct structure
% and contains all the needed files.
% 
%   checkSubmission(ANDREWID) checks 'ANDREWID.zip' for the correct structure
% 1. The .zip file should directly produce *.m and *.mat files when
% uncompressed
% 2. run this function with the <andrewid> string. example: checkSubmission('janedoe')

    errors = 0;
    TMPDIR = '.tmpunzip';
    mkdir(TMPDIR)

    ZIPFILE = strcat(andrewid, '.zip');
    ROOT = strcat(TMPDIR, '/');

    if exist(ZIPFILE, 'file') == 2
        disp('found');
        unzip(ZIPFILE, TMPDIR)
    else
        fprintf('Could not find handin zip. Please make sure your zipfile is named %s.\n', ZIPFILE)
        errors = errors+1;
        fprintf('Found %d problems.\n', errors)
        return
    end

    matlabfiles = {
        'LucasKanade.m',
        'LucasKanadeBasis.m',
        'LucasKanadeAffine.m',
        'SubtractDominantMotion.m',
        'testCarSequence.m',
        'testSylvSequence.m',
        'testAerialSequence.m',
        'testCarSequenceWithTemplateCorrection.m',
        'carseqrects.mat',
        'carseqrects-wcrt.mat',
        'sylvseqrects.mat',
        }';

    for i = matlabfiles
        mfile = strcat(ROOT, '/', i{1});
        if exist(mfile, 'file') ~= 2
            fprintf('%s not found.\n', mfile)
            errors = errors+1;
        end
    end
    
    if errors == 0
        fprintf('Zip file structure looks good.\n')
    else
        fprintf('Found %d problems.\n', errors)
    end

    rmdir(TMPDIR, 's')
end
