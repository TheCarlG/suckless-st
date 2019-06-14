// GruvBox Dark
static const char *colorname[] = {
	[0]   = "#191919",  /* black */
	[1]   = "#cc241d",  /* red */
	[2]   = "#98971a",  /* gren */
	[3]   = "#d79921",  /* yellow */
	[4]   = "#458588",  /* blue */
	[5]   = "#b16286",  /* magenta */
	[6]   = "#689d6a",  /* cyan */
	[7]   = "#a89984",  /* white */

	[8]   = "#928374",  /* black */
	[9]   = "#fb4934",   /* red */
	[10]  = "#b8bb26",  /* green */
	[11]  = "#fabd2f",  /* yellow */
	[12]  = "#83a598",  /* blue */
	[13]  = "#d3869b",  /* magenta */
	[14]  = "#8ec07c",  /* cyan */
	[15]  = "#ebdbb2",  /* white */

	[256] = "#191919", /* background */
	[257] = "#ebdbb2", /* foreground */
};

/*
 * Default colors (colorname index)
 * foreground, background, cursor, reverse cursor
 */
// # hard contrast: background = '0x1d2021'
unsigned int defaultfg = 257;
unsigned int defaultbg = 256;
static unsigned int defaultcs = 257;
static unsigned int defaultrcs = 257;
