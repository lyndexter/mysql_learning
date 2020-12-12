select ship,country
from outcomes left join (Select name,country from Ships left join Classes on ships.class=classes.class) t on outcomes.ship=t.name
where result="sunk" and t.country is not null;