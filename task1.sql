select concat(to_date(concat('2018', to_char(sold_at, 'IW')), 'iyyyiw'), ' - ',
              to_date(concat('2018', to_char(sold_at, 'IW')), 'iyyyiw') + 6),
       SUM(price)
FROM transactions
GROUP BY to_char(sold_at, 'IW')