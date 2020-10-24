<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>
<head>
    <title>简历列表</title>


</head>
<body>

<div style="position: initial;float: left;width: 60%;">

    <table id="list" border="1">
        <tr>
            <th style="width:60px;">ID</th>
            <th style="width:60px;">姓名</th>
            <th style="width:60px;">地址</th>
            <th style="width:60px;">电话</th>
            <th style="width:60px;">操作</th>
        </tr>
    </table>

</div>

<div style="position: initial;float: left;width: 30%;">
    添加：
    <br/><br/>
    <input type="hidden" id="hidId" />
    姓名：<input type="text" id="name" />
    <br>
    地址：<input type="text" id="address" />
    <br>
    电话：<input type="text" id="phone" />
    <br>
    <input type="button" id="btnSave" value="保存" />
</div>
</body>
</html>
<script src="../js/jquery.min.js"></script>
<script>
    // 查询整个列表
    function queryAll() {
        clearTable();
        $.ajax({
            url: '/resume/queryAll',
            type: 'POST',
            contentType: 'application/json;charset=utf-8',
            dataType: 'json',
            success: function (data) {
                //生成表格数据
                $.each(data, function (index, item) {
                    $('<tr id="tr' + item.id + '"><td>'
                        + item.id + '</td><td>'
                        + item.name + '</td><td>'
                        + item.address + '</td><td>'
                        + item.phone + '</td><td><input type="button" value="修改"  onclick="update('+item.id+')"/>'
                        +'<input type="button" value="删除" onclick="del('+item.id+')"/></td></tr>').appendTo($("#list"));
                });
            }
        })
    }
    function clearTable(){
        const table = document.getElementById("list");
        const rows = table.rows.length;
        //清空表中的行和列
        for(let a=1; a<rows; a++){
            $("table tr").eq(1).remove();
        }
    }
    $(function () {
        queryAll();

        //保存
        $("#btnSave").click(function () {
            const data = JSON.stringify({
                "id":$("#hidId").val(),
                "name":$("#name").val(),
                "address":$("#address").val(),
                "phone":$("#phone").val(),
            })
            $.ajax({
                url: '/resume/save',
                type: 'POST',
                data:data,
                contentType: 'application/json;charset=utf-8',
                dataType: 'json',
                success: function (data) {
                    if(data){
                        queryAll();
                        $("#hidId").val("");//隐藏域存放修改之前的行的ID编号值
                        $("#name").val("");
                        $("#address").val("");
                        $("#phone").val("");
                    }
                }
            })

        });
    })
    function update(id){
        //显示添加界面
        const tds = $("#tr" + id).children('td');
        //设置文本框的值
        $("#hidId").val(tds[0].innerHTML);//隐藏域存放修改之前的行的ID编号值
        $("#name").val(tds[1].innerHTML);
        $("#address").val(tds[2].innerHTML);
        $("#phone").val(tds[3].innerHTML);
    }
    function del(id) {
        $.ajax({
            url: '/resume/delete',
            type: 'POST',
            data:JSON.stringify({
                "id":id,
            }),
            contentType: 'application/json;charset=utf-8',
            dataType: 'json',
            success: function (data) {
                if(data){
                    queryAll();
                }
            }
        })
    }
</script>