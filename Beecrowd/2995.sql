SELECT temperature, COUNT(mark) AS number_of_records
from records
GROUP BY temperature, mark
ORDER BY mark