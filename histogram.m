function [] = histogram(img)
    dim = size(img);
    hist = zeros(1,256);
    for x = 1:dim(1)
        for y = 1:dim(2)
            hist(1,img(x,y) + 1) = hist(1,img(x,y) + 1) + 1;
        end
    end
    px = (0:255);
    bar(px, hist);
end
    