function [conf] = evaluateRecognitionSystem()
% Evaluates the recognition system for all test-images and returns the confusion matrix

	load('vision.mat');
	load('../data/traintest.mat');

    test_labels = getLabels(test_imagenames, mapping);
    
    wordMaps = strrep(test_imagenames, '.jpg','.mat');
    wordMaps = strcat('../data/', wordMaps);
    for i =1: numel(wordMaps)
        wordMaps{i} = load(wordMaps{i}, 'wordMap');
        wordMaps{i} = wordMaps{i}.wordMap;
    end

    conf= zeros(8);

    for i=1:numel(test_imagenames)
        h = getImageFeaturesSPM(3, wordMaps{ i }, size(dictionary,2));
        distances = distanceToSet(h, train_features);
        [~,nnI] = max(distances);
        guessedImage = train_labels(nnI)
        test_labels(i)
        conf(guessedImage,test_labels(i)) = conf(guessedImage,test_labels(i)) +1;
    end

    accuracy = trace(conf)/sum(conf(:))


end
