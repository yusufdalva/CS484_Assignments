function[dilated_image] = dilation(source_image, struct_el)
    dim = size(source_image);
    dilated_image = zeros(dim(1), dim(2));
    struct_dim = size(struct_el);
    %% Zero padding the input image
    % Padding in order to apply the window to every pixel
    input_img = padarray(source_image, [floor(struct_dim(1)/2), floor(struct_dim(2)/2)], 0, "both");
    pad_dim = size(input_img);
    %% Traversing through image pixels
    for x = ceil(struct_dim(1)/2): pad_dim(1) - floor(struct_dim(1)/2)
        for y = ceil(struct_dim(2)/2): pad_dim(2) - floor(struct_dim(2)/2)
            % If there is a hit in the image by the structuring element,
            % pixel (x,y) set to 1
            x_bound = 0;
            y_bound = 0;
            if mod(size(struct_el, 1), 2) == 1
                x_bound = [x - floor(struct_dim(1) / 2), x + floor(struct_dim(1) / 2)];
            else
                x_bound = [x - ceil(struct_dim(1) / 2) + 1, x + ceil(struct_dim(1) / 2)];
            end
            if mod(size(struct_el,2),2) == 1
                y_bound = [y - floor(struct_dim(2) / 2), y + floor(struct_dim(2) / 2)];
            else
                y_bound = [y - ceil(struct_dim(1) / 2) + 1, y + ceil(struct_dim(1) / 2)];
            end
            window = input_img(x_bound(1): x_bound(2), y_bound(1): y_bound(2));
            flag = 0;
            for i = 1:size(window, 1)
                for j = 1:size(window,2)
                    if struct_el(i,j) == 1 && window(i,j) == 1
                        dilated_image(x - ceil(struct_dim(1) / 2) + 1,y - ceil(struct_dim(2) / 2) + 1) = 1;
                        flag = 1;
                        break;
                    end
                end
                if flag == 1
                    break;
                end
            end
            if flag == 0
                dilated_image(x - ceil(struct_dim(1) / 2) + 1,y - ceil(struct_dim(2) / 2) + 1) = 0;
            end
        end
    end
end