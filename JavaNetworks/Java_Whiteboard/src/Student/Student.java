package Student;

import javax.swing.*;
import java.awt.*;
import java.awt.event.ActionEvent;
import java.awt.event.ActionListener;
import java.awt.event.MouseEvent;
import java.awt.event.MouseListener;
import java.io.BufferedReader;
import java.io.OutputStream;
import java.io.PrintStream;

public class Student extends JFrame implements ActionListener,Runnable, MouseListener {
    private String NickName = null;
    private JScrollPane jsp = new JScrollPane();
    private JButton Send = new JButton("发送消息");
    private JButton Send_Record = new JButton("举手发言");
    private JButton Leave = new JButton("离开课堂");
    private DefaultListModel<String> user = new DefaultListModel<String>();  //用户列表
    private JList<String> userList = new JList<String>(user);   //展示用户列表
    private JScrollPane listPane = new JScrollPane(userList);       //设置滚动视图
    private JTextField Sendword = new JTextField(20);       //发文字区域
    private JTextArea Chat = new JTextArea(10,45);     //聊天记录显示
    private JLabel myself = new JLabel("",JLabel.CENTER);
    private JLabel friend_list = new JLabel("在线学生",JLabel.CENTER);
    private JLabel exp1 = new JLabel("智慧课堂学生端",JLabel.CENTER);
    private JPanel paintBoard = new JPanel();   //画图板
    public PrintStream ps = null;
    public BufferedReader br = null;
    private String path;
    private int[] shapePoint=new int[4];		//绘制图形的四个点
    private Graphics2D g2d;                     //Graphics2D类型的画笔
    private OutputStream out;
    private RecordMain re = null;

    public Student(String Nick, String path, PrintStream ps, BufferedReader br, OutputStream out) throws Exception{
        this.ps = ps;
        this.br = br;
        this.path = path;
        this.out = out;

        user.addElement(Nick);


        ps.println("NEW");
        Font font = new Font("微软雅黑", Font.PLAIN, 15);

        paintBoard.setBounds(500,0,598,598);
        paintBoard.setBackground(Color.white);      //设置为白板

        Chat.setFont(font);
        Chat.setLineWrap(true);         //设置自动换行
        Chat.setLocation(0,0);
        Chat.setEditable(false);        //聊天记录无法编辑
        Chat.setMargin(new Insets(7, 7, 7, 7));     //设置7mm边距

        JScrollPane jsp = new JScrollPane(Chat);         //设置一个滚动条
        jsp.setBounds(0,0,500,500);

        //设置控件位置
        Sendword.setLocation(0,500);
        Sendword.setSize(300,60);
        Sendword.setFont(new Font("微软雅黑", Font.PLAIN, 20));
        Sendword.addActionListener(this);

        Send.addActionListener(this);
        Send.setSize(100,60);
        Send.setLocation(300,500);
        Send.setFont(font);
        Send.setMargin(new Insets(0,0,0,0));   //设置按钮边框和标签之间空白为0

        Send_Record.addActionListener(this);
        Send_Record.setSize(100,60);
        Send_Record.setLocation(400,500);
        Send_Record.setFont(font);
        Send_Record.setMargin(new Insets(0,0,0,0));   //设置按钮边框和标签之间空白为0

        Leave.addActionListener(this);
        Leave.setSize(85,69);
        Leave.setLocation(1099,429);
        Leave.setFont(font);
        Leave.setMargin(new Insets(0,0,0,0));   //设置按钮边框和标签之间空白为0
        Leave.setBackground(new Color(255,255,204));          //设置按钮颜色为淡黄

        exp1.setSize(100,20);     //好友列表四个字
        exp1.setLocation(1093,510);
        exp1.setFont(new Font("微软雅黑", Font.BOLD, 11));

        listPane.setSize(86,289);
        listPane.setLocation(1099,140);

        userList.setFont(font);
        userList.addMouseListener(this);    //用于监听私聊
        userList.repaint();

        ImageIcon image = new ImageIcon(path);  //将图片路径作为参数传入
        image.setImage(image.getImage().getScaledInstance(85,90,Image.SCALE_DEFAULT));  //创建缩放版本图像
        JLabel Picture = new JLabel(image);
        Picture.setLocation(1100,0);
        Picture.setSize(85,90);

        this.NickName = Nick;        //构造函数传入参数

        myself.setText(NickName);
        myself.setSize(100,20);
        myself.setLocation(1093,95);
        myself.setFont(new Font("微软雅黑", Font.BOLD, 15));

        friend_list.setSize(100,20);     //好友列表四个字
        friend_list.setLocation(1093,118);
        friend_list.setFont(new Font("微软雅黑", Font.BOLD, 15));

        new Thread(this).start();
        //客户端文件读写线程启动,将自己JFrame作为参数传入
        ClientFileThread fileThread = new ClientFileThread(NickName,this,ps);
        fileThread.start();

        //窗体基本设置
        this.setLayout(null);
        this.add(paintBoard);
        this.add(jsp);
        this.add(exp1);
        this.add(Sendword);
        this.add(Send);
        this.add(Send_Record);
        this.add(listPane);
        this.add(Picture);
        this.add(myself);
        this.add(friend_list);
        this.add(Leave);
        this.setTitle(NickName+"的课堂");
        this.setLocation(200,100);
        this.setSize(1200,598);
        this.setDefaultCloseOperation(EXIT_ON_CLOSE);
        this.setVisible(true);

        Graphics g = paintBoard.getGraphics();         //获取画笔
        g2d=(Graphics2D) g;      //将Graphics转为Graphics2D
        g2d.setStroke(new BasicStroke(3.0f));   //设置画笔宽度
    }

    public void run(){
        while(true){
            try{
                String message = br.readLine();
                String[] msgs = message.split("-");
                if(msgs[0].equals("LOGOUT")){//退出课堂
                    ps.println("RUN-"+NickName);        //使服务器能够让别人知道消息
                    JOptionPane.showMessageDialog(this, "您已离开课堂！再见！");
                    this.dispose();
                }else if(msgs[0].equals("SLOGIN")){//有人进入课堂
                    Chat.append("欢迎"+msgs[1]+"进入课堂!\n");
                    if(!msgs[1].equals(NickName)){
                        user.addElement(msgs[1]);       //将用户加入好友列表
                    }
                    userList.repaint();
                } else if(msgs[0].equals("USER")){
                    user.addElement(msgs[1]);           //服务器为客户端发送之前的好友列表
                } else if(msgs[0].equals("SLOGOUT")){//有人离开课堂
                    user.removeElement(msgs[1]);    //将用户移除好友列表
                    userList.repaint();
                } else if(msgs[0].equals("CARE")){//提醒专心听课
                    JFrame jf = this;				//获得现在的界面
                    new Thread() {      //开启窗口抖动线程
                        long begin = System.currentTimeMillis();
                        long end = System.currentTimeMillis();
                        Point p = jf.getLocationOnScreen();
                        public void run() {//实现窗口抖动
                            int i = 1;
                            while ((end - begin) / 1000 < 2) {
                                jf.setLocation(new Point((int) p.getX() - 5 * i, (int) p.getY() + 5 * i));  //Point函数构造并初始化点
                                end = System.currentTimeMillis();
                                try {
                                    Thread.sleep(5);
                                    i = -i;
                                    jf.setLocation(p);
                                } catch (InterruptedException e) {
                                    e.printStackTrace();
                                }
                            }
                        }
                    }.start();
                }else if(msgs[0].equals("OKRECORD")){//教师同意发言请求
                    re = new RecordMain();           //进入录制界面
                    re.setLocationRelativeTo(this);  //设置在本页面中间
                    WaitingThread waiting = new WaitingThread();
                    waiting.start();
                }else if(msgs[0].equals("NORECORD")){//教师拒绝发言请求
                    JOptionPane.showMessageDialog(this,"教师拒绝了您的发言请求！");
                }else if(msgs[0].equals("LINE") ||msgs[0].equals("YUAN")||
                        msgs[0].equals("JUXING")||msgs[0].equals("QIANBI")||msgs[0].equals("HUABI")) {
                    //改变画笔的粗细
                    if(msgs[0].equals("LINE")){
                        g2d.setStroke(new BasicStroke(3.0f));
                    }
                    if(msgs[0].equals("QIANBI")){
                        g2d.setStroke(new BasicStroke(3.0f));
                    }else if(msgs[0].equals("HUABI")){
                        g2d.setStroke(new BasicStroke(5.0f));
                    }
                    //动作类型+四个点
                    readShape(msgs[0],Integer.parseInt(msgs[1]),Integer.parseInt(msgs[2]),
                            Integer.parseInt(msgs[3]),Integer.parseInt(msgs[4]));
                }else if(msgs[0].equals("EMPTY")){
                    paintBoard.paint(g2d);			//画布清空
                }else if(msgs[0].equals("YANSE")){
                    changeColor(msgs[1]);			//msgs[1]为颜色英语单词
                }else{
                    Chat.append(message+"\n");
                }
            }catch(Exception e){}
        }
    }

    public void actionPerformed(ActionEvent e){
        if(e.getSource() == Send || e.getSource() == Sendword) {//发送消息
            ps.println(NickName + "-" + Sendword.getText());
            Sendword.setText("");               //清空文本框
        }
        else if(e.getSource() == Send_Record){//举手发言
            ps.println("RECORD-"+NickName);
        }else if(e.getSource() == Leave){      //要走了
            ps.println("LEAVE");
        }
    }

    public void mouseClicked(MouseEvent e) {
        if(e.getClickCount() == 2) {        //监听双击事件
            ps.println("SILIAO" + "-" + userList.getSelectedValue());       //向服务器发送想私聊信息
        }
    }
    //以下均为重写方法
    public void mouseEntered(MouseEvent e) {}
    public void mouseExited(MouseEvent e) {}
    public void mousePressed(MouseEvent e) {}
    public void mouseReleased(MouseEvent e) {}

    public void readShape(String OP,int point1,int point2,int point3,int point4){
        //只要是传输两个点的图形绘制操作都可以用这一条
        try {
            switch(OP){
                case "LINE":
                case "QIANBI":
                case "HUABI":
                    g2d.drawLine(point1,point2,point3,point4);break;//画线
                case "YUAN":
                    g2d.fillOval(point1,point2,point3,point4);break;//画圆
                case "JUXING":
                    g2d.fillRect(point1,point2,point3,point4);break;//画矩形
            }
        } catch (Exception e) {}
    }

    public void changeColor(String color){//改变画笔颜色
        try {
            switch(color){
                case "RED": g2d.setColor(Color.red);break;
                case "YELLOW":
                    g2d.setColor(Color.yellow);break;
                case "BLUE": g2d.setColor(Color.blue);break;
                case "GREEN":g2d.setColor(Color.green); break;
                case "BLACK":g2d.setColor(Color.black); break;
                case "WHITE":g2d.setColor(Color.white); break;
            }
        } catch (Exception e) {}
    }

    class WaitingThread extends Thread{
        public void run(){
            while(true){
                try{
                    Thread.sleep(50);//每隔50毫秒检查一次
                }catch(Exception e){}
                if(RecordMain.flag){
                    //已经录完，利用该函数发送文件到服务器
                    ClientFileThread.outFileToServer(MyRecorder.path);
                    RecordMain.flag = false;    //将值设为false，用于下一次发语音
                    break;
                }
            }
        }
    }
}
