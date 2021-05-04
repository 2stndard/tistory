font_add(family = "나눔손글씨 펜", regular = 'C:/USERS/ESTND/APPDATA/LOCAL/MICROSOFT/WINDOWS/FONTS/NANUMPEN.TTF')

ggplot(pressure, aes(x = temperature, y = pressure)) + 
  geom_point() + 
  labs(title = 'PDF 사용 예제 플롯', x = '온도', y = '압력') + 
  theme(text=element_text(size=16, family="나눔손글씨 펜"))


font_add(family = "나눔손글씨 펜", regular = 'C:/USERS/ESTND/APPDATA/LOCAL/MICROSOFT/WINDOWS/FONTS/NANUMPEN.TTF')
