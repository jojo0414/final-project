import SwiftUI

struct GameInfo: View {
    var body: some View {
        VStack(alignment: .leading){
            VStack(alignment: .center)
            {
                Group{
                    Text("無數生靈繁衍聚集的廣袤大陸\n")
                    Text("提瓦特\n")
                        .font(.title2)
                        .foregroundColor(.green)
                    Text("天地萬象蘊含其間\n")
                    Text("這裡是\n")
                    Text("七神統治、七種元素\n")
                        .font(.title2)
                        .foregroundColor(Color.cyan)
                    Text("交匯的世界……\n")
                }
                
                Group{
                    Text("陌生的天空下\n")
                    Text("少年少女").font(.title2).foregroundColor(Color.yellow) +
                    Text("立於塵沙\n")
                    Text("你們是一對旅行中的雙子\n")
                    Text("從") +
                    Text("世界之外").font(.title2).foregroundColor(Color.brown) +
                    Text("漂流而來\n")
                    Text("你的血親被陌生的神靈帶走\n")
                    Text("而你也被神封印\n")
                    Text("陷入沉眠\n")
                }
                
                Group{
                    Text("再度醒來\n")
                    Text("天地間風景已") +
                    Text("改變……\n").font(.title2).foregroundColor(Color.yellow)
                }
            }
        }
    }
}

struct GameInfoPreview: PreviewProvider {
    static var previews: some View {
        GameInfo()
    }
}
