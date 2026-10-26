# Analize podataka u biološkim istraživanjima - praktikum 25/26
# Lucija Kanjer lucija.kanjer@biol.pmf.hr

##############################################################

# 4. Grafički prikaz bioloških podataka u R-u -2

# Uključene su sve korištenje naredbe, ALI NEKE SU NEPOTPUNE ILI SADRŽE NAMJERNE POGREŠKE:
# Dovršite naredbe i također dodajte komentare za sebe (koristite # za komentiranje)
#
# IZVRŠAVANJE NAREDBI: ctrl + Enter 
#
#############################################################

# Učitavanje paketa
library(ggplot2) # paket za crtanje grafova
library(dplyr) # paket za manipulaciju tablicama
library(palmerpenguins) # paket o pingvinima

theme_set(theme_minimal()) #postavljanje teme minimalnog izgleda za sve grafove

penguins <- penguins

View(penguins)

##############################################################


# Grafički prikazi po tipu varijabli

# 1. Grafički prikazi kategoričkih varijabli

# Barplot za prikaz broja pingvina po vrstama.
ggplot(penguins, aes(x = species)) + 
  geom_bar()

# Kako prikazati kategorije vrste od najbrojnije do najmanje brojne?
# Moramo pretvoriti kategoričku varijablu "species" u faktor!

penguins$species <- factor(penguins$species, 
                           levels = names(sort(table(penguins$species), decreasing = TRUE)))

# 2. Grafički prikazi numeričkih varijabli
# 2.1 Histogram za prikaz distribucije mase tijela pingvina.
ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 100, color = "black", fill = "aquamarine")

# Poigrajte se s opcijom "binwidth"!
# Što se događa s grafom? Koja vrijednost najbolje pokazuje distrubuciju?

# Napravite histogram za još jednu numeričku varijablu!
# Koja opcija binwidth je najbolja za tu varijablu?


# 3. Prikaz odnosa između dvije kategoričke varijable

# 3.1 Stacked bar plot
ggplot(data = penguins, aes(x = species, fill = sex)) +
  geom_bar()

# 3.1 Bar plot
ggplot(data = penguins, aes(x = species, fill = sex)) +
  geom_bar(position = "dodge")

# 3.2 Relativni odnos
ggplot(data = penguins, aes(x = species, fill = sex)) +
  geom_bar(position = "fill")

# Uklonite nedostajuće vrijednosti pa ponovite barplot po izboru!

# 4. Prikaz odnosa između dvije numeričke varijable
# 4.1 Točkaskti graf (scatter plot)
ggplot(data = penguins, aes(x = bill_length_mm, y = bill_depth_mm)) +
  geom_point(aes(shape = species, color = species))

# 5. Prikaz odnosa između numeričke i kategoričke varijable
# 5.1 Box plot
ggplot(data = penguins, aes(x = species, y = body_mass_g, fill = species)) +
  geom_boxplot()

# 5.2 Strip chart (jitter)
ggplot(data = penguins, aes(x = species, y = body_mass_g, color = species)) +
  geom_jitter()

# Kombinacija boxplota i jittera
ggplot(data = penguins, aes(x = species, y = body_mass_g, fill = species)) +
  geom_boxplot() + geom_jitter()

# 5.3 Violin plot
ggplot(data = penguins, aes(x = species, y = body_mass_g, fill = species)) +
  geom_violin()

# 5.4 Višestruki histogrami
ggplot(data = penguins, aes(x = body_mass_g, fill = species)) +
  geom_histogram(binwidth = 200, color = "black") +
  facet_wrap(~ species, ncol = 1, scales = "free_y", strip.position = "right")

# Zadatak: Napravite višestruki histogram za duljinu peraja!

### Spajanje više grafova u jedan - paket patchwork

#install.packages("patchwork")
library(patchwork)

# prvo spremamo grafove u objekte
barplot <- ggplot(penguins, aes(x = species, fill = species)) + 
  geom_bar()

histogram <- ggplot(penguins, aes(x = body_mass_g)) +
  geom_histogram(binwidth = 300, color = "black", fill = "aquamarine")

# Ispis barplota jedan pored drugoga
barplot + histogram

# Zadatak: ispišite barplot i histogram jedan ispod drugoga!


### Eksportiranje ggplot grafa kao slike ili PDF dokumenta

ggsave(filename = "histogram.jpg", # naziv JPG slike
       plot = histogram, # koji objekt želimo eksportirati
       width = 8, height = 6, # dimenzije u inčima
       dpi = 300) # dots per inch

ggsave(filename = "histogram.pdf", 
       plot = histogram,
       width = 8, height = 6, 
       device = cairo_pdf) # naziv metode eksporta za PDF

# Gdje se spremila slika grafa?

################################################################

# Zadaci - odaberite i napravite prikladan tip grafa za svaku od slijedećih zadataka:

# 1. samo za Gentoo vrstu: prikaz razdiobe duljine peraja,
# 2. sve vrste: prikaz broja jedinki po otocima,
# 3. sve vrste: prikaz ovisnosti duljine peraja o masi pingvina, kategorije obojane po vrsti,
# 4. samo za Adelie vrstu: usporedba mase pingvina po spolu, s uklonjenim nedostajućim vrijedonstima te bojama ispune po spolu,
# 5. sve vrste: prikaz broja jedinki različitih vrsta pingvina po otocima.

# 6. Eksportirajte graf po želji kao PNG sliku.
# 7. Instalirajte paket RColorBrewer, istražite kako se koristi te promjenite paletu boja na grafu po izboru.

# Pomoćna pitanja za provjeru izrade dobrog grafa:
# Je li graf čitljiv i kontrastan?
# Jesu li osi jasno označene i na hrvatskom jeziku?
# Pokazuje li boja informaciju ili samo dekoraciju?


