if [[ $TB_LOAD_AWS != 1 ]]; then
	echo "Skip aws alias"
	return
fi

if ((!$ + commands[aws])); then
	echo "aws command not found, skip aws alias"
else
	alias acost='aws ce get-cost-and-usage --metrics UnblendedCost --granularity MONTHLY '
	alias ari='aws ce get-reservation-coverage --metrics Hour Unit Cost'
	alias ari2='aws ce get-reservation-utilization --granularity=MONTHLY'
	alias asp2='aws ce get-savings-plans-utilization --granularity=MONTHLY'
	alias asp='aws ce get-savings-plans-coverage'
fi

if ((!$ + commands[awless])); then
	echo "awless command not found, skip awless alias"
else
	alias ali='awless list instances'
	alias adi='awless delete instance'
	alias alk='awless list keypairs'
	alias aci='awless create instance'
	alias assh='awless ssh'
fi
