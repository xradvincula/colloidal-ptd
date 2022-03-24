#!/bin/bash

# this script outputs another script with some variables replaced

CMD=$(cat <<'EOF'
#!/bin/bash
pushd "./runs/$TS-$RUNS/" > /dev/null
TOTAL_BASINS=$(grep 'SET COMMITTED TO BASIN' * | grep -v '^bck.*$' | awk -F':' '{ print $2 }' | sort | uniq -c | awk '{ sum+=$1 } END{ print sum }')
BASIN_2=$(grep 'SET COMMITTED TO BASIN' * | grep -v '^bck.*$' | awk -F':' '{ print $2 }' | sort | uniq -c | grep 'SET COMMITTED TO BASIN 2' | awk '{ print $1 }')
# we can have 0 in basin 2, if so, just output 0
#if [ -z '${BASIN_2}' ];
#then
#  echo 0
#  exit 0
#fi
#echo "$TS" "$BASIN_2/$TOTAL_BASINS" | bc -l

com=$(expr '$BASIN_2' / '$TOTAL_BASINS')
echo $TS $com
EOF
)

TS=$1
RUNS=$2
export TS RUNS
printf "%s\n" "$CMD" | envsubst > out.tmp
