# Rješenja zadataka - Grafički prikazi 2

# Zadaci - odaberite i napravite prikladan tip grafa za svaku od slijedećih zadataka:
# 1. samo za Gentoo vrstu: prikaz razdiobe duljine peraja
gentoo <- filter(penguins, species == "Gentoo")

ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 300, color = "black", fill = "pink")

# 2. sve vrste: prikaz broja jedinki po otocima
ggplot(penguins, aes(x = island)) + 
  geom_bar()

# 3. sve vrste: prikaz ovisnosti duljine peraja o masi pingvina, podatke obojajte po vrsti
ggplot(data = penguins, aes(x = body_mass_g, y = flipper_length_mm)) +
  geom_point(aes(color = species))

# 4. samo za Adelie vrstu: usporedba mase pingvina po spolu, s uklonjenim nedostajućim vrijedonstima te bojama ispune po spolu
adelie <- penguins %>% 
  select(species, sex, body_mass_g) %>%
  filter(species == "Adelie")%>%
  na.omit()

ggplot(data = adelie, aes(x = sex, y = body_mass_g, fill = sex)) +
  geom_boxplot()

# 5. sve vrste: prikaz broja jedinki različitih vrsta pingvina po otocima
ggplot(data = penguins, aes(x = island, fill = species)) +
  geom_bar() 

# 6. Eksportirajte graf po želji kao PNG sliku.
boxplot <- ggplot(data = adelie, aes(x = sex, y = body_mass_g, fill = sex)) +
  geom_boxplot()

ggsave(filename = "boxplot.png", plot = boxplot, width = 8, height = 6, dpi = 300)

# 7. Instalirajte paket RColorBrewer, istražite kako se koristi te promjenite paletu boja na grafu po izboru.

install.packages("RColorBrewer")
library(RColorBrewer)

ggplot(data = penguins, aes(x = body_mass_g, y = flipper_length_mm)) +
  geom_point(aes(color = species)) + 
  scale_color_brewer(palette = "Dark2")

