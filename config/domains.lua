---------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- WezTerm SSH配置                                                                                                                                                 --
-- 作者:忘羽梦汐                                                                                                                                                   --
-- 功能介绍:这段代码是 WezTerm 终端模拟器的配置片段，主要用于定义不同类型的远程连接域（Domain），包括 SSH 连接、Unix 域套接字连接和 Windows 子系统 Linux (WSL) 连接--
---------------------------------------------------------------------------------------------------------------------------------------------------------------------

return {
	-- SSH 远程连接域配置
	ssh_domains = {
		{
			name = "Kali-linux", -- 唯一名称
			remote_address = "192.168.44.147:22", -- 远程地址与端口
			username = "kali", -- 登录用户名
			multiplexing = "None", -- 关闭多路复用，避免兼容性问题
			ssh_option = {
				identityfile = "C:\\Users\\Fizz\\.ssh\\id_rsa", -- SSH 私钥路径
			},
		},
		{
			name = "Alma-linux",
			remote_address = "host.myalmalinux.com:22",
			username = "root",
			multiplexing = "None",
			ssh_option = {
				identityfile = "C:\\Users\\Fizz\\.ssh\\id_rsa",
			},
		},
	},

	-- Unix 域套接字配置（暂未使用）
	unix_domains = {},

	-- WSL 连接配置
	wsl_domains = {
		{
			name = "WSL:Ubuntu",
			distribution = "Ubuntu", -- WSL 发行版名
			username = "kevin", -- 登录用户名
			default_cwd = "/home/kevin", -- 默认工作目录
			default_prog = { "fish" }, -- 默认启动 shell
		},
	},
}
