-- Insert 200 realistic Indian customers
INSERT INTO customers (name, gender, dob, signup_date, city)
SELECT 
    -- Full Name: Firstname + Lastname
    first_names[ceil(random() * array_length(first_names, 1))] || ' ' ||
    last_names[ceil(random() * array_length(last_names, 1))],

    -- Random gender
    CASE WHEN random() < 0.5 THEN 'M' ELSE 'F' END,

    -- Random date of birth (between 1970 and 1997)
    DATE '1970-01-01' + (trunc(random() * 10000)::int) * INTERVAL '1 day',

    -- Random signup date within last 3 years
    CURRENT_DATE - (trunc(random() * 1095)::int) * INTERVAL '1 day',

    -- Random city
    cities[ceil(random() * array_length(cities, 1))]
FROM generate_series(1, 200),
LATERAL (
    SELECT 
        ARRAY[
            'Aarav', 'Priya', 'Rohan', 'Ananya', 'Vikram', 'Sneha', 'Arjun', 'Kavita', 
            'Rahul', 'Meera', 'Aditya', 'Pooja', 'Karthik', 'Divya', 'Suresh', 'Nisha', 
            'Amit', 'Ritu', 'Rajesh', 'Sunita'
        ] AS first_names,
        ARRAY[
            'Sharma', 'Patel', 'Singh', 'Kumar', 'Gupta', 'Reddy', 'Iyer', 'Nair', 
            'Desai', 'Mehta', 'Joshi', 'Verma', 'Malhotra', 'Chatterjee', 'Rao', 
            'Kapoor', 'Banerjee', 'Mishra', 'Das', 'Sen'
        ] AS last_names,
        ARRAY[
            'Mumbai', 'Delhi', 'Bangalore', 'Hyderabad', 'Chennai', 'Kolkata', 
            'Pune', 'Ahmedabad', 'Jaipur', 'Lucknow', 'Chandigarh', 'Kochi'
        ] AS cities
) name_data;

SELECT * FROM customers;

-- Insert accounts (1-2 per customer) with realistic 12-digit Indian account numbers and random balances
INSERT INTO accounts (customer_id, account_number, account_type, open_date, balance)
SELECT 
    c.customer_id,
    LPAD((trunc(random() * 1e12)::bigint)::text, 12, '0') AS account_number,
    (ARRAY['savings', 'current', 'loan'])[floor(random() * 3 + 1)],
    c.signup_date + (trunc(random() * 90)::int) * INTERVAL '1 day',
    round((1000 + random() * 499000)::numeric, 2) -- Realistic INR balances (₹1,000 to ₹5,00,000)
FROM customers c
JOIN generate_series(1, 2) AS dup(n) ON true
WHERE random() < 0.75		-- Around 75% of customers get a second account
ORDER BY c.customer_id
LIMIT 1000;

SELECT * FROM accounts;

-- Insert 1000 well-randomized transactions
INSERT INTO transactions (account_id, transaction_type, amount, transaction_date, description)
SELECT 
    t.account_id,
    t.transaction_type,
    t.amount,
    t.transaction_date,
    d.description
FROM (
    SELECT 
        a.account_id,
        -- Randomly assign credit or debit
        CASE 
            WHEN random() < 0.5 THEN 'debit' 
            ELSE 'credit' 
        END AS transaction_type,
        -- Random amount between ₹500 and ₹2,50,000
        ROUND((500 + random() * 249500)::numeric, 2) AS amount,
        -- Random date within past 2 years
        NOW() - (trunc(random() * 730) || ' days')::INTERVAL AS transaction_date
    FROM accounts a,
         generate_series(1, 10) gs
) t
-- Attach description based on type
JOIN LATERAL (
    SELECT 
        CASE 
            WHEN t.transaction_type = 'credit' THEN
                (ARRAY[
                    'Salary credited',
                    'NEFT transfer from HDFC Bank',
                    'Credit alert from ICICI Bank',
                    'Reversal of failed transaction',
                    'Loan disbursement',
                    'UPI wallet top-up',
                    'Refund from vendor',
                    'IMPS reversal',
                    'Received from customer',
                    'Online payment received',
                    'Cash deposit at branch'
                ])[FLOOR(random() * 11 + 1)::int]
            ELSE
                (ARRAY[
                    'POS payment at D-Mart',
                    'Jio prepaid recharge',
                    'Fuel purchase at Indian Oil',
                    'Electricity bill payment (Tata Power)',
                    'Loan EMI debit',
                    'House rent payment',
                    'Online purchase at Flipkart',
                    'Cash withdrawal from SBI ATM',
                    'Netflix subscription payment',
                    'Health insurance premium debit',
                    'NEFT transfer to Axis Bank'
                ])[FLOOR(random() * 11 + 1)::int]
        END AS description
) d ON TRUE
ORDER BY random()
LIMIT 1000;

SELECT * FROM transactions;

-- Confirm balanced transaction type
SELECT 
	transaction_type, 
	COUNT(*) 
FROM transactions 
GROUP BY transaction_type;

-- See variety of descriptions
SELECT 
	description, 
	COUNT(*) 
FROM transactions 
GROUP BY description 
ORDER BY COUNT(*) DESC;

-- Count total rows
SELECT 
	COUNT(*) 
FROM transactions;