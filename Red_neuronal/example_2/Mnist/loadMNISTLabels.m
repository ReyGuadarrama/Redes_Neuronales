function labels = loadMNISTLabels(filename)
%loadMNISTLabels returns a [number of MNIST images]x1 matrix containing
%the labels for the MNIST images

fp = fopen(filename, 'rb');
assert(fp ~= -1, ['Could not open ', filename, '']);

magic = fread(fp, 1, 'int32', 0, 'ieee-be');
assert(magic == 2049, ['Bad magic number in ', filename, '']);

numLabels = fread(fp, 1, 'int32', 0, 'ieee-be');

temp = fread(fp, inf, 'unsigned char');

samples = size(temp,1);
labels = zeros(10, samples);

for i=1:samples
    n = temp(i) + 1;
    labels(n,i) = 1;
end

assert(size(temp,1) == numLabels, 'Mismatch in label count');

fclose(fp);

end
