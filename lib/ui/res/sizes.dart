/// Определения размеров экранных элементов

const double wideScreenSizeOver = 450;  // считать широким экран более 450
const double appBarHeight = 30;  // высота AppBar
const double basicBorderSize = 30;  // отступ "обертки" для экранов от краев
const int firstHourOnScreen = 8; // первая часовая полоска на экране - 8:00
const double hourStripHeight = 32; // высота часовой полоски
const double distanceBetweenStripesOfAnHour = 4; // расстояние между часовыми полосками
const startingOffsetOfListOfHourStripes = (hourStripHeight + distanceBetweenStripesOfAnHour) * firstHourOnScreen;
const double heightOfTextFieldsAndButtons = 30; // высота текстовых полей и кнопок
