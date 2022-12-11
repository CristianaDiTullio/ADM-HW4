#!/bin/bash

echo ""
echo ""
echo "LET'S START!"
echo ""
echo ""

#Question 1
echo "1) Which location has the maximum number of purchases been made?"
echo ""
#The location with the maximum number of transactions is equivalent to the most common location
#present in our dataset. So we count how many locations we have and the number of occurrences per location,
#and finally take the one that appears the most.
cut -d, -f 5 bank_transactions.csv | \
sort | uniq -c | sort -rn -k 1 | head -n 1 | \
awk -F' ' '{print "The answer is " $2 " with " $1 " transactions."}'
echo ""
echo ""

#Question 2
echo "2) In the dataset provided, did females spend more than males, or vice versa?"
echo ""
#We select the columns Gender and TransactionAmount and save them on an auxiliary file.
#Then, on this file we perform all the operations to answer the question, considering first
#the total expense for gender and then the average one.
cut -d, -f 4,9 bank_transactions.csv > aux_2.csv
echo "- In total:"
v1="$(grep "M" aux_2.csv | awk -F, '{count=count+$2} END {printf "%.2f \n", count}' | bc)"
v2="$(grep "F" aux_2.csv | awk -F, '{count=count+$2} END {printf "%.2f \n", count}' | bc)"
echo "Males spent: $v1"
echo "Females spent: $v2"
if (( $(echo "$v1 > $v2" | bc -l) ))
then
    echo "So, males spent more in total."
else
    echo "So, females spent more in total."
fi
echo ""
echo "- However, presumably the numbers of females and males are not the same."
n1="$(grep "M" aux_2.csv | awk -F, '{males=males+1} END {print males}' | bc)"
n2="$(grep "F" aux_2.csv | awk -F, '{females=females+1} END {print females}' | bc)"
echo "In fact, the male people are $n1 and the female people are $n2."
echo "Thus, we compute the average expense per gender."
echo ""
echo "- On average:"
v1="$(grep "M" aux_2.csv | awk -F, '{count=count+$2; n++} END {printf "%.2f \n", count/n}' | bc)"
v2="$(grep "F" aux_2.csv | awk -F, '{count=count+$2; n++} END {printf "%.2f \n", count/n}' | bc)"
echo "Males spent: $v1"
echo "Females spent: $v2"
if (( $(echo "$v1 > $v2" | bc -l) ))
then
    echo "So, males spent more on average."
else
    echo "So, females spent more on average."
fi
echo ""
echo ""

#Question 3
echo "3) Report the customer with the highest average transaction amount in the dataset."
echo ""
#The purpose of the following code snippet is to:
# - Select all the unique IDs that are in bank_transactions.csv and save them in a dedicated file unique_ids.txt;
# - Iterate on all those ids to reproduce the behaviour of a groupby;
# - For each id, look for it in bank_transactions.csv and compute the average transaction amount;
# - For each computation, save a line Customer_ID, Number_Of_Transactions, Average_Transaction_Amount in another auxiliary file;
# - Finally, order the auxiliary file by Average_Transaction_Amount and take the customer with greatest amount.
#DON'T DECOMMENT THE NEXT LINES, as their execution takes a huge amount of time and we already provide its output.
#awk -F, '{print $2}' bank_transactions.csv | sort | uniq > unique_ids.txt
#cat unique_ids.txt | while read id
#do
#    grep $id bank_transactions.csv | awk -F, '{count=count+$9; n++} END {if (n > 0) print $2 "," n "," count/n}' >> aux_3.txt
#done
sort -t',' -rg -k 3 aux_3.txt | head -n 1 | \
awk -F, '{printf "Customer " $1 ", with average transaction amount: %.2f \n", $3}'
echo ""
echo ""