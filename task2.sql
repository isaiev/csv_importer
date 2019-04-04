WITH sum_per_week_per_employee AS
       (SELECT to_char(sold_at, 'IW')  AS                                                 week_num,
               SUM(price)              as                                                 sum,
               employees.coffeeshop_id as                                                 coffeeshop_id,
               employees.name          as                                                 employee_name,
               employees.name          as                                                 employee_id,
               rank() over (partition by to_char(sold_at, 'IW') order by SUM(price) desc) employee_rank
        FROM transactions
               INNER JOIN employees ON employees.id = transactions.employee_id
        GROUP BY to_char(sold_at, 'IW'), employees.id)

SELECT concat(to_date(concat('2018', week_num), 'iyyyiw'), ' - ',
              to_date(concat('2018', week_num), 'iyyyiw') + 6) as week,
       coffeeshops.name                                        as Coffeeshop,
       employee_name                                           as Employee,
       sum                                                     as "Revenue (total £ for coffees sold)"
FROM sum_per_week_per_employee
       INNER JOIN coffeeshops ON sum_per_week_per_employee.coffeeshop_id = coffeeshops.id
WHERE employee_rank = 1
