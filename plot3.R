library(lubridate) # We're going to use this to make parsing the date/time easier.

#
# Read in the data.
#
# This is a semicolon-delimited text file, where missing values are represented as "?". We only want the data for the
# dates 2/1/2007 and 2/2/2007, so the skip and nrows parameters are set so that we only read the applicable rows.
power <- read.table("household_power_consumption.txt", sep=";", skip=66637, nrows = 2880, stringsAsFactors = FALSE, na.strings = "?",
                    col.names = c("date", "time", "globalactivepower", "globalreactivepower", "voltage", "globalintensity", "submetering1", "submetering2",
                                  "submetering3"),
                    colClasses = c("character", "character", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric", "numeric"))

# Replace the date column with the date and time columns converted to a POSIXct value.
power$date <- with(power, dmy_hms(paste(date, time), tz = "US/Pacific"))

# Now that date captures both the date and time, strip out the time column.
power <- power[,c(1,3:9)]

par(bg = "white") # Don't want transparent backgrounds.

#
# Build plot 3 - a line graph of the three submetering values over time
#

# First build the plot. No plotting yet. We'll add the lines for the three separate submetering variables in a sec.
with(power, plot(date, submetering1, type = "n", xlab = "", ylab = "Energy sub metering"))

# Add the line for submetering1.
with(power, lines(date, submetering1, col = "black"))

# Next the line for submetering2.
with(power, lines(date, submetering2, col = "red"))

# Then the line for submetering3.
with(power, lines(date, submetering3, col = "blue"))

# The last thing we'll add is the legend.
legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lwd = 1, lty = 1, cex = .8)

# Copy the completed plot to a png file.
dev.copy(png, "plot3.png")

# All done.
dev.off()
