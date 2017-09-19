function buildRecognitionSystem()
% Creates vision.mat. Generates training features for all of the training images.

	load('dictionary.mat');
	load('../data/traintest.mat');

    train_labels = getLabels(train_imagenames, mapping);
    [a dictionarySize] = size(dictionary);
    
    wordMaps = strrep(train_imagenames, '.jpg','.mat');
    wordMaps = strcat('../data/', wordMaps);
    for i =1: numel(wordMaps)
        wordMaps{i} = load(wordMaps{i}, 'wordMap');
        wordMaps{i} = wordMaps{i}.wordMap;
    end

    getIF_SPM=@(wM) getImageFeaturesSPM(3, wM, dictionarySize);
    train_features = cellfun(getIF_SPM, wordMaps, 'UniformOutput',0);
    train_features = cat(2,train_features{:}); 

    save('vision.mat', 'filterBank', 'dictionary', 'train_features', 'train_labels');

end

