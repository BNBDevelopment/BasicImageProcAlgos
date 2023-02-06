myimg = readraw("resources/data/images/City.raw", 422, 750, false);


city_yuv = transform_yuv(myimg);

city_y = city_yuv(:,:,1);
city_uv = city_yuv(:,:,2:3);

%ybuckets = get_grey_buckets(city_y);
%[tf_y, transfer_fn] = eq_hist_buckets(ybuckets, city_y);
%[b_y, cdf] = bucketfill(city_y);

%tfy_img = cat(3, tf_y, city_uv);
%by_img = cat(3, b_y, city_uv);

%ychan = tfy_img(:,:,1);
%tf_rgb = yuv_to_rgb(tfy_img);
%rchanl = tf_rgb(:,:,1);
%gchanl = tf_rgb(:,:,1);
%bchanl = tf_rgb(:,:,1);

%b_rgb = yuv_to_rgb(by_img);

%city_rgb = yuv_to_rgb(city_yuv);
%written01 = writeraw(city_rgb, "city_TEST.png", false);

%written01 = writeraw(tf_rgb, "city_transfer.png", false);
%written02 = writeraw(b_rgb, "city_bucket.png", false);
%imshow(city_y)
written01 = writeraw(city_y, "aaa.png", true);
city_y = city_y / 255;
clahe_y = adapthisteq(city_y, 'clipLimit',0.002,'NumTiles',[16 16]) * 255;
written01 = writeraw(clahe_y, "bbb.png", true);
%imshow(clahe_y)
clahe_img = cat(3, clahe_y, city_uv);
clahe_rgb = yuv_to_rgb(clahe_img);
%imshow(clahe_rgb)
written01 = writeraw(clahe_rgb, "city_clahe.png", false);


function yuv_img = transform_yuv(myimg)
    yuv_img = zeros(size(myimg,1), size(myimg,2), 3);
    for row = 1:size(myimg,1)
        for col = 1:size(myimg,2)
            r = myimg(row, col, 1);
            g = myimg(row, col, 2);
            b = myimg(row, col, 3);

            yuv_img(row, col, 1) = ceil((0.257 * r) + (0.504 * g) + (0.098 * b) + 16); %Y
            yuv_img(row, col, 2) = ceil(-(0.148 * r) - (0.291 * g) + (0.439 * b) + 128); %U
            yuv_img(row, col, 3) = ceil((0.439 * r) - (0.368 * g) - (0.071 * b) + 128); %V

        end
    end
end

function rgb_img = yuv_to_rgb(yuvimg)
    rgb_img = zeros(size(yuvimg,1), size(yuvimg,2), 3);
    counter = 0;
    for row = 1:size(yuvimg,1)
        for col = 1:size(yuvimg,2)
            counter = counter + 1;
            y = yuvimg(row, col, 1);
            u = yuvimg(row, col, 2);
            v = yuvimg(row, col, 3);

            r = fix(1.164*(y - 16) + 1.596*(v - 128)); %R
            r = max(0,r(:));
            r = min(255,r(:));
            g = fix(1.164*(y - 16) - 0.813*(v - 128) - 0.391*(u - 128)); %G
            g = max(0,g(:));
            g = min(255,g(:));
            b = fix(1.164*(y - 16) + 2.018*(u - 128)); %B
            b = max(0,b(:));
            b = min(255,b(:));
            rgb_img(row, col, 1) = r; %R
            rgb_img(row, col, 2) = g; %G
            rgb_img(row, col, 3) = b; %B

        end
    end
    counter
end