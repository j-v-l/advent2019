
## Set-up --------------------------------------------------------------------------------------

# Load packages
library(tidyverse)

# Load input file
dat <- read_csv(col_names = "mass", "data/day01_input.txt")


## Part 1 --------------------------------------------------------------------------------------

# Fuel required to launch a given module is based on its mass. Specifically, to find the fuel 
# required for a module, take its mass, divide by three, round down, and subtract 2. What is the 
# sum of the fuel requirements for all of the modules on your spacecraft?

dat %>%
  mutate(fuel = floor(mass / 3) - 2) %>%
  summarise(total_fuel = sum(fuel))


## Part 2 --------------------------------------------------------------------------------------

# Fuel itself requires fuel just like a module - take its mass, divide by three, round down, and 
# subtract 2. However, that fuel also requires fuel, and that fuel requires fuel, and so on. Any 
# mass that would require negative fuel should instead be treated as if it requires zero fuel. What 
# is the sum of the fuel requirements for all of the modules on your spacecraft when also taking 
# into account the mass of the added fuel? (Calculate the fuel requirements for each module 
# separately, then add them all up at the end.)

unfueled_mass <- dat$mass
total_fuel_required <- 0

while (sum(unfueled_mass) > 0) {
  
  fuel_required <- floor(unfueled_mass / 3) - 2
  fuel_required[fuel_required < 0] <- 0
  
  total_fuel_required <- total_fuel_required + sum(fuel_required)
  unfueled_mass <- fuel_required
  
}

total_fuel_required

