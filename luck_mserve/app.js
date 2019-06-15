const mysql = require("mysql");
const express = require("express");

//创建连接池
const pool = mysql.createPool({
  host:"127.0.0.1",
  user:"root",
  password:"",
  database:"mluck"
});

//4:创建express对象
var server = express(); 

//跨域配置
const cors = require("cors");
server.use(cors({
   origin:["http://127.0.0.1:8080",
   "http://localhost:8080"],
   credentials:true
}))

// 添加session功能
const session = require('express-session');
server.use(session({
  secret: "128位字符串",
  resave: false,
  saveUninitialized: true
}))

server.listen(3000);
//指定静态目录.保存图片资源
server.use(express.static("public"));

// 接收用户登录请求
server.get("/login",(req,res)=>{

  var uname = req.query.uname;
  var upwd = req.query.upwd;
  var sql = `
    select uid from luck_user where uname = ? and upwd = md5(?)
  `;
  pool.query(sql,[uname,upwd],(err,result)=>{
    // console.log(result[0].uid)
    if(err) throw err;
    if(result.length==0){
      res.send({code:-1,msg:'用户名或密码有误'})
    }else{
      req.session.uid = result[0].uid;
      // 将session发送个前端
      res.send({code:1,msg:result,uid:req.session.uid})
    }
  })
  // 登录成功时执行
  // 返回结果result[{id:1}]
  // req.session.uid = result[0].id
  // 这里session后面不能直接写uid，因为session有内置的id属性
})

// 当客户端存在session的时候，通过session存储的uid查询指定用户的信息并返回
server.get('/userLogin',(req,res)=>{
  // var uid = req.session.uid;
  var uid = req.query.uid;
  var sql = `select uname,upwd from luck_user where uid = ?`;
  pool.query(sql,[uid],(err,result)=>{
    if(err) throw err;
    if(uid){
      res.send({code:1,msg:result})
    }
  })
});

// 查询所有订单列表
server.get('/getAllList',(req,res)=>{
  // var uid = req.session.uid;
  var uid = req.query.uid;
  var sql = `select id,state,store,lname,price,ltime from shop_list where uid=?`;
  pool.query(sql,[uid],(err,result)=>{
    if(err) throw err;
    if(uid){
      res.send({code:1,msg:result})
    }
  })
});


// 查询指定编号订单列表
server.get('/getList',(req,res)=>{
  var sql = `
    select state,store,lname,price,ltime from shop_list where id=?
  `;
  pool.query(sql,[req.query.id],(err,result)=>{
    if(err) throw err;
    res.send({code:1,msg:result})
  })
});

// 查询购物车列表
server.get('/getCart',(req,res)=>{
  // var uid = 2;
  var uid = req.query.uid;
  var sql = `
    select id,cname,ceng,price,count from shop_cart where uid=?
  `;
  pool.query(sql,[uid],(err,result)=>{
    if(err) throw err;
    if(uid){
      res.send({code:1,msg:result})
    }
  })
});

// 删除购物车(单条)
server.get('/removeCarItem',(req,res)=>{
  var id = req.query.id;
  var sql = "DELETE FROM shop_cart WHERE id=?";
  pool.query(sql,[id],(err,result)=>{
    if(err)throw err;
    if(result.affectedRows==0){
      res.send({code:-1,msg:"删除失败"});
    }else{
      res.send({code:1,msg:"删除成功"});
    }
 });
})

// 添加商品至购物车
server.get('/addCart',(req,res)=>{
  // var uid = 2;
  var uid = req.query.uid;
  var name = req.query.cofName;
  var eng = req.query.cofEng;
  var pri = req.query.cofPri;

  var sql = `
    INSERT INTO shop_cart VALUES(null,'${name}','${eng}',${pri},1,${uid});
  `;
  pool.query(sql,[name,eng,pri,uid],(err,result)=>{
    if(err) throw err;
    if(uid){
      res.send({code:1,msg:result})
    }else{
      res.send({code:-1,msg:'请登录'})
    }
  })
});