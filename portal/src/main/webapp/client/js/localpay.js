/**
 *1.获取签到状态
 *返回值	1，成功；	0，失败
 *插卡消费前，获取签到状态进行判断。签到成功才能进行插卡消费
 */
function IsSignIn(){
	var flag = WinForm.IsSignIn();
	return flag;
}
/**
 *2.开启插卡
 *iSecond：插卡超时时间，单位秒
 */

function InsertCard(iSecond) {
	WinForm.InsertCard(iSecond);
}

/**
 * 
 * 3.开启闪付寻卡
 *iSecond：插卡超时时间，单位秒
 */
function RfActiveCard(iSecond) {
	WinForm.RfActiveCard(iSecond); 
}

/**
 *4.取消插卡或闪付寻卡
 * @param postCode
 * @returns {Boolean}
 */
function CancelPushCard(){
	WinForm.CancelPushCard();
}
/**
 * 5.消费(插卡消费、闪付)
 * @param consumetype 消费类型：1插卡消费；7闪付 2输入凭证号消费；3扫码消费
 * @param consumeinfo 消费信息：“金额|流水号” ,金额精确到分。如”0.01” ,流水号长度6位。如”123456”
 * 二维码支付时 消费信息为：消费信息：“金额|凭证号|密码” ，凭证号：扫码消费时传空，密码：可为空
 * 
 * @returns 
 */
function Consume(consumetype, consumeinfo){
	WinForm.Consume(consumetype, consumeinfo);
}


/**
 *6.二维码小额获取签到状态
 *返回值	1，成功；	0，失败
 *插卡消费前，获取签到状态进行判断。签到成功才能进行插卡消费
 */
function IsSignIn4xe(){
	var flag = WinForm.BarcodePay_IsSignIn();
	return flag;
}

/**
 *7.二维码小额消费
 *返回值	1，成功；	0，失败
 *consumetype	消费类型：2输入凭证号消费；3扫码消费
   consumeinfo	消费信息：“金额|凭证号|密码”
   凭证号：扫码消费时传空
    密码：可为空
 */
function Consume4xe(consumetype, consumeinfo){
	WinForm.BarcodePay_Consume(consumetype, consumeinfo);
}


/**
 *8,关闭窗口
 */
function winclose(){
	WinForm.Close();
}