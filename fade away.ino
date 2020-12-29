


#define ValueGap 405
//该数值可用砝码校准

long HX711_Buffer = 0;
long Weight_Maopi = 0,Weight_Shiwu = 0;
float Weight = 0;
#define HX711_SCK A0
#define HX711_DT A1
int maxp=716;
int p=0;
void setup()
{
	Init_Hx711();				//初始化HX711模块连接的IO设置

	Serial.begin(115200);
  delay(1000);
//	Serial.print("Welcome to use!\n");
  Get_Maopi();
}

void loop()
{
	Weight = Get_Weight();	//计算放在传感器上的重物重量
//	Serial.print(Weight);	//串口显示重量
//	Serial.print(" g\n");	//显示单位
	delay(100);		//延时1s
  p=map(Weight ,0,1000,0,maxp);
  if(p<0)
   p=0;
  if(p>maxp)
   p=maxp;   
 // Serial.println(String(p)+",0");
   Serial.println(String(int(Weight))+",0");
}

void Init_Hx711()
{
  pinMode(HX711_SCK, OUTPUT); 
  pinMode(HX711_DT, INPUT);
}


//****************************************************
//获取毛皮重量
//****************************************************
void Get_Maopi()
{
  Weight_Maopi = HX711_Read();    
} 

//****************************************************
//称重
//****************************************************
unsigned int Get_Weight()
{
  HX711_Buffer = HX711_Read();

  Weight_Shiwu = HX711_Buffer;
  Weight_Shiwu = Weight_Shiwu - Weight_Maopi;       //获取实物的AD采样数值。
  
  Weight_Shiwu = (int)((float)Weight_Shiwu/ValueGap+0.05);  

  return Weight_Shiwu;
}

//****************************************************
//读取HX711
//****************************************************
unsigned long HX711_Read(void)  //增益128
{
  unsigned long count; 
  unsigned char i;
  bool Flag = 0;

  digitalWrite(HX711_DT, HIGH);
  delayMicroseconds(1);

  digitalWrite(HX711_SCK, LOW);
  delayMicroseconds(1);

    count=0; 
    while(digitalRead(HX711_DT)); 
    for(i=0;i<24;i++)
  { 
      digitalWrite(HX711_SCK, HIGH); 
    delayMicroseconds(1);
      count=count<<1; 
    digitalWrite(HX711_SCK, LOW); 
    delayMicroseconds(1);
      if(digitalRead(HX711_DT))
      count++; 
  } 
  digitalWrite(HX711_SCK, HIGH); 
  delayMicroseconds(1);
  digitalWrite(HX711_SCK, LOW); 
  delayMicroseconds(1);
  count ^= 0x800000;
  return(count);
}
