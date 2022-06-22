CREATE DATABASE ecommerce;

USE ecommerce;

# To_see_the_structure_of_table
DESC users_data;

SELECT * FROM users_data;

#SQL command to select first 100 rows of the database
SELECT * FROM users_data LIMIT 100;

# Finding how many distinct values exist in table for field country and language
SELECT 
    COUNT(DISTINCT country) Distinct_countries,
    COUNT(DISTINCT language) Distinct_languages
FROM
    users_data;


# Checking whether male users are having maximum followers or female users.
SELECT 
    gender, COUNT(socialNbFollowers) Number_of_followers
FROM
    users_data
GROUP BY gender;


# Calculating the total users those
-- Use Profile Picture in their Profile
SELECT COUNT(hasProfilePicture) FROM users_data WHERE hasProfilePicture = 'True';

-- Use Application for Ecommerce platform
SELECT COUNT(hasAnyApp) FROM users_data WHERE hasAnyApp = 'True';

-- Use Android app
SELECT COUNT(hasAndroidApp) FROM users_data WHERE hasAndroidApp = 'True';

-- Use ios app
SELECT COUNT(hasIosApp) FROM users_data WHERE hasIosApp = 'True';


# Calculating the total number of buyers for each country and sort the result in descending order of total number of buyers.
SELECT 
    country, COUNT(productsBought) Number_of_buyers
FROM
    users_data
WHERE
	productsBought > 0
GROUP BY country
ORDER BY COUNT(productsBought) DESC;


# Calculating the average number of sellers for each country and sort the result in ascending order of total number of sellers. 
SELECT 
    country, COUNT(productsSold) Number_of_sellers
FROM
    users_data
WHERE 
	productsSold > 0
GROUP BY country
ORDER BY COUNT(productsSold) ASC;


# Displaying the name of top 10 countries having maximum products pass rate.
SELECT 
    country, MAX(productsPassRate)
FROM
    users_data
GROUP BY country
ORDER BY MAX(productsPassRate) DESC
LIMIT 10;


# Calculating the number of users on an ecommerce platform for different language choices.
SELECT 
    language, COUNT(*) Number_of_Users
FROM
    users_data
GROUP BY language;


# Checking the choice of female users about putting the product in a wishlist or to like socially on an ecommerce platform.
SELECT 
    SUM(productsWished),
    SUM(socialProductsLiked)
FROM
    users_data
WHERE
    gender = 'F' AND hasAnyApp ='true'
ORDER BY productsWished DESC;



# Checking the choice of male users about being seller or buyer.
SELECT 
    SUM(productsSold),
    SUM(productsBought)
FROM
    users_data
WHERE
    gender = 'M'
ORDER BY productsSold DESC;


# Finding out which country is having maximum number of buyers?
SELECT 
    country, COUNT(productsBought) Number_of_buyers
FROM
    users_data
WHERE
    productsBought > 0
GROUP BY country
ORDER BY COUNT(productsBought) DESC
LIMIT 1;

# Listing the name of 10 countries having zero number of sellers.
SELECT 
    COUNTRY, COUNT(PRODUCTSSOLD) ZERO_SELLERS
FROM
    USERS_DATA
WHERE
    productsSold = 0
GROUP BY COUNTRY
HAVING country != ALL (SELECT 
        COUNTRY AS SELLERS
    FROM
        USERS_DATA
    WHERE
        PRODUCTSSOLD != 0
    GROUP BY COUNTRY);
SELECT 
	COUNTRY AS SELLERS
    FROM
        USERS_DATA
    WHERE
        PRODUCTSSOLD != 0
    GROUP BY COUNTRY;

# Displaying the record of top 110 users who have used ecommerce platform recently.
SELECT 
    *
FROM
    users_data
ORDER BY daysSinceLastLogin ASC
LIMIT 110;


# Calculating the number of female users those who have not logged in since last 100 days.
SELECT 
    COUNT(*)
FROM
    users_data
WHERE
    gender = 'F'
        AND daysSinceLastLogin > 100;


# Displaying the number of female users of each country at ecommerce platform.
SELECT 
    country, COUNT(*) Female_Users
FROM
    users_data
WHERE
    gender = 'F' AND hasAnyApp ='true'
GROUP BY country
ORDER BY COUNT(*) DESC;


# Displaying the number of male users of each country at ecommerce platform
SELECT 
    country, COUNT(*) Male_Users
FROM
    users_data
WHERE
    gender = 'M' AND hasAnyApp ='true'
GROUP BY country;


# Calculating the average number of products sold and bought on ecommerce platform by male users for each country.
SELECT 
    country, AVG(productsSold), AVG(productsBought)
FROM
    users_data
WHERE
    gender = 'M' AND hasAnyApp='true'
GROUP BY country;