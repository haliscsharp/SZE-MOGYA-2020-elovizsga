
param nRows>=0;
set Rows:=1..nRows;

param cashierCount>=0;
param cashierLength>=0;

set ProductGroups;
param space{ProductGroups}>=0;

var alignment{Rows,ProductGroups}>=0,binary;


var rl{Rows};
var currentLongest;

s.t. InitRow{r in Rows:r>cashierCount}:
    rl[r]=sum{p in ProductGroups} alignment[r,p]*space[p];

s.t. AddCashierToRow{r in Rows:r<=cashierCount}:
    rl[r]=cashierLength+(sum{p in ProductGroups}alignment[r,p]*space[p]);

s.t. CalcBuldingLen{r in Rows}:
    rl[r]<=currentLongest;

s.t. GroupsCannotBeSplitBetweenRows{p in ProductGroups}:
    sum{r in Rows} alignment[r,p]=1;




minimize BuildingLength: currentLongest;

solve;

printf "%f\n",BuildingLength;

end;