function labels = getLabels(imageNames, mapping)
labels = zeros(numel(imageNames),1);
for i = 1:numel(mapping)
    labels =labels+contains(imageNames, mapping{i})*i;
end
end
