# Original color palette sequence
MG <- c("#559999", "#BB650B", "firebrick4", "olivedrab3", "tomato2", "#336633", "#7570b3", "#2e4057", "#8d96a0", "gold", "#FF7F00", "#0072B2", "#4DAF4A", "#FF0000", "#66a182", "#999999", "#2e4057", "#8d96a0", "#0e669b", "#00798c", "dodgerblue4", "steelblue2", "#00AFBB", "#E7B800", "#FC4E07", "lightskyblue4", "#663300", "green", "red", "#FFF000", "#0099CC", "#FF9933", "#CC9900", "chartreuse1", "#FF3399", "#00FFFF", "#0000CC", "#00AFBB", "red", "#A37F6F", "#9183E6", "#00AD9A", "#990033", "#909800", "#00FF00", "#17b5b4", "#AED1D6", "#b1010c", "firebrick2", "blue", "green", "navy", "yellow", "#00AFBB", "#E7B800", "#FC4E07", "brown", "black", "purple", "darkred", "darkgreen", "#82cfd0", "#b2e0e4", "honeydew3", "#8d96a3", "lavender", "#CC6686", "lavenderblush2", "mistyrose3", "#e1deda", "darkgoldenrod", "burlywood", "papayawhip", "wheat4", "cornsilk3", "khaki2", "beige", "gray60", "gray80", "gray96", "cadetblue4", "#82cfd0", "#b2e0e4", "honeydew2", "mintcream", "#0e668b", "#a3c4dc", "lightskyblue1", "aliceblue", "blue", "red", "green", "lavender", "lavenderblush2", "mistyrose3", "#e1deda", "darkgoldenrod", "burlywood", "papayawhip", "wheat4", "cornsilk3", "khaki2", "beige", "gray60")

# Extend the color palette sequence
extended_palette <- c(MG, rainbow(100))

# Check the length of the extended palette
length(extended_palette)

# Use the extended palette for your plot
#scale_color_manual(values = extended_palette)
