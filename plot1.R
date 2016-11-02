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
# Build plot1 - a histogram of power$globalactivepower
#

# First build the plot.
hist(power$globalactivepower, xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "red", main = "Global Active Power")

# Then copy it to a png file.
dev.copy(png, "plot1.png")

# All done.
dev.off()
