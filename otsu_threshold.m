function[binary_image] = otsu_threshold(source_image)
    %% First step is to compute the histogram
    dim = size(source_image);
    hist = zeros(1,256);
    for x = 1:dim(1)
        for y = 1:dim(2)
            hist(1,source_image(x,y) + 1) = hist(1,source_image(x,y) + 1) + 1;
        end
    end
    %% Computing the mean and variance of the image
    prob_hist = hist;
    img_sum = 0;
    dist_dim = size(prob_hist);
    for x = 1:dist_dim(2)
        img_sum = img_sum + (x - 1) * prob_hist(x);
    end
    %% Computing moving variances (for minimum within class variance)
    t = 0;
    q_1 = 0; % q_1(t) -- initially q_1(0) = 0
    sum_1 = 0;
    m_1 = 0; % m_1(t) -- initially m_1(0) = 0
    m_2 = 0;
    var = (q_1 * (1 - q_1) * (m_1 - m_2)^2);
    for x = 1:dist_dim(2)
        q_1 = q_1 + prob_hist(x);
        if q_1 == 0
            continue;
        end
        q_2 = (dim(1) * dim(2)) - q_1;
        if q_2 == 0
            break;
        end
        sum_1 = sum_1 + ((x - 1) * prob_hist(x));
        m_1 = sum_1 / q_1;
        m_2 = (img_sum - sum_1) /q_2;
        t_var = (q_1 * q_2 * (m_1 - m_2)^2);
        if t_var > var
            var = t_var;
            t = x - 1;
        end
    end
    disp(t);
    %% Change the input matrix according to the treshold value
    dim = size(source_image);
    binary_image = zeros(dim(1), dim(2));
    for x = 1:dim(1)
        for y = 1:dim(2)
            if source_image(x,y) < t
                binary_image(x,y) = 0;
            else
                binary_image(x,y) = 255;
            end
        end
    end
end