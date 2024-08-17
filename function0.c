const int sm83 = 
	#ifdef __SDCC_sm83
		1
	#else
		0
	#endif
;

int function0(int de)
{
	return de | sm83;
}
