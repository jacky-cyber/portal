DELIMITER $$

CREATE DEFINER=`dev`@`%` FUNCTION `currval`(seq_name VARCHAR(50)) RETURNS varchar(40) CHARSET utf8
BEGIN
DECLARE valuep VARCHAR(40);
SELECT current_value INTO valuep FROM t_sequence WHERE NAME = seq_name; UPDATE t_sequence SET current_value = current_value + 1 WHERE NAME = seq_name;
RETURN valuep;
end$$
