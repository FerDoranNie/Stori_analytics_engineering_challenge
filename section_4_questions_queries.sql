-- How many users are there in total? 
SELECT 
	COUNT(DISTINCT users.user_id) AS unique_users
FROM defaultdb.users AS users; 


-- How many users have transacted?
SELECT
	CASE 
		WHEN transactions.transaction_id IS NOT NULL 
		THEN 'Make a transaction'
		ELSE 'User no make a transaction'
	END,
	COUNT(DISTINCT users.user_id) AS users
FROM defaultdb.users AS users 
LEFT JOIN defaultdb.transactions AS transactions ON 
	(users.user_id= transactions.user_id)
GROUP BY 1 


-- What is the card delivery rate?
-- I suppose that transaction type online and suscription are related to card (credit card) so 
WITH filteredData AS (
	SELECT 
		SUM(CASE 
			WHEN packages.delivery_status= 'delivered'
			THEN 1 ELSE 0
		END) AS delivered_packages,
		SUM(1) AS total_packages
	FROM defaultdb.transactions AS transactions 
	LEFT JOIN defaultdb.packages AS packages ON 
		(transactions.user_id= packages.user_id)
	WHERE transactions.transaction_type IN ('subscription', 'online')
)
SELECT 
	filteredData.delivered_packages,
	filteredData.total_packages,
	filteredData.delivered_packages/filteredData.total_packages AS delivery_rate
FROM filteredData




-- Which is the most efficient package courier?
WITH courierPerformance AS (
	SELECT 
		packages.courier,
		SUM(CASE 
			WHEN packages.delivery_status= 'delivered'
			THEN 1 ELSE 0
		END) AS delivered_packages,
		COUNT(1) AS total_packages
	FROM defaultdb.packages AS packages 
	GROUP BY 1
)
SELECT 
	courier,
	delivered_packages, 
	total_packages,
	delivered_packages/total_packages AS efficiency
FROM courierPerformance
ORDER BY 4 DESC 


-- Which are the top 10 categories with the most transactions?
SELECT 
	CONCAT(transactions.transaction_type, '-', packages.delivery_status) AS category ,
	SUM(1) AS transactions 
FROM defaultdb.transactions  AS transactions 
LEFT JOIN defaultdb.packages AS packages ON 
	(transactions.user_id= packages.user_id)
GROUP BY 1 
ORDER BY 2 DESC 
LIMIT 10 
