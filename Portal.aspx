<%@ Page Language="C#" AutoEventWireup="true" CodeBehind="Portal.aspx.cs" Inherits="CreekPortal.Portal"
    ValidateRequest="false" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <title>Creek Portal - the P2P Download Platform Administration Dashboard</title>
    <link rel="shortcut icon" type="image/x-icon" href="jQuery/themes/Creek Icons/favicon.ico" />
    <link rel="stylesheet" type="text/css" href="jQuery/themes/gray/easyui.css" />
    <link rel="stylesheet" type="text/css" href="jQuery/themes/icon.css" />
    <link rel="stylesheet" type="text/css" href="jQuery/themes/Creek Icon.css" />
    <link rel="stylesheet" type="text/css" href="Portal.css" />
    <script type="text/javascript" src="jQuery/jquery-1.6.min.js"></script>
    <script type="text/javascript" src="jQuery/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="jQuery/jquery.json-2.3.min.js"></script>
</head>
<body onload="onload();" style="overflow: hidden;">
    <div id="main_dashboard" class="easyui-layout" style="width: 100%; height: 100%;">
        <!-- Title of Dashboard -->
        <div region="north" split="false" style="overflow: hidden; height: 26px; padding: 0px">
            <h2 class="panel-header" style="font-size: medium; border: 0px;">
                <span id="portal_banner" style="background-image: url('jQuery/themes/Creek Icons/application-monitor.png');
                    background-repeat: no-repeat"></span>
            </h2>
        </div>
        <!-- Content List Panel -->
        <div region="west" title="Content List" icon="icon-blue-documents" split="true" style="width: 200px;">
            <div id="tb_content_list" class="datagrid-toolbar">
                <a href="#" id="cmd_content_refresh"></a><a href="#" id="cmd_new_content"></a>
            </div>
            <ul id="tr_content_list">
            </ul>
        </div>
        <!-- Seed List Panel -->
        <div region="east" title="Seed List" icon="icon-network-clouds" split="true" style="width: 200px;">
            <div id="tb_seed_list" class="datagrid-toolbar">
                <a href="#" id="cmd_seed_refresh"></a>
            </div>
            <ul id="tr_seed_list">
            </ul>
        </div>
        <!-- System Notification Panel -->
        <div region="south" title="System Notifications" icon="icon-system-monitor-network"
            split="true" style="height: 200px;">
            <table id="gd_notification_list">
            </table>
        </div>
        <!-- Content Detail Panel -->
        <div region="center" style="overflow: auto">
            <div id="ac_content_detail" class="easyui-accordion" fit="true" border="false">
                <!-- Content Summary -->
                <div title="Summary" iconcls="icon-blue-document" style="overflow: auto;" selected="true">
                    <table id="gd_content_summary">
                    </table>
                    <div id="tb_content_summary">
                        <a href="#" id="cmd_new_version"></a>
                    </div>
                </div>
                <!-- Work in Progress -->
                <div title="Work in Progress" iconcls="icon-blue-document-task" style="overflow: auto;">
                    <table id="gd_work_in_progress">
                    </table>
                    <div id="tb_work_in_progress">
                        <a href="#" id="cmd_interrupt_all"></a>
                    </div>
                </div>
                <!-- Content Version List -->
                <div title="Version List" iconcls="icon-blue-document" style="overflow: auto;">
                    <table id="gd_version_list">
                    </table>
                    <div id="tb_version_list">
                        <a href="#" id="cmd_deploy_content"></a><a href="#" id="cmd_content_offline"></a>
                        <a href="#" id="cmd_pause_seeds"></a><a href="#" id="cmd_resume_seeds"></a>
                        <a href="#" id="cmd_get_metafile"></a><a href="#" id="cmd_get_downloader"></a>
                        <a href="#" id="cmd_regen_downloader"></a>
                    </div>
                </div>
                <!-- Torrent Seed Detail -->
                <div title="Version Status" iconcls="icon-blue-document" style="overflow: auto;">
                    <table id="gd_torrent_seed_detail">
                    </table>
                </div>
            </div>
        </div>
    </div>
    <!-- begin of new content dialog box ui definitions -->
    <div id="nc_dlg" class="easyui-dialog" style="padding: 10px 25px; width: 500px; height: 450px;"
        title="建立新的下載內容物" buttons="#nc_dlg_buttons" iconcls="icon-blue-document" closed="true"
        shadow="true" modal="true">
        <form id="nc_form">
        <div class="ftitle">
            下載內容物</div>
        <div class="fitem">
            <label>
                內容代碼:</label>
            <input id="nc_content_id" class="combo" style="width: 240px; height: 20px" />&nbsp;&nbsp;
            <input id="nc_auto_deploy" type="checkbox" class="tree-checkbox" style="height: 20px" /><span>佈署?</span>
        </div>
        <div class="fitem">
            <label>
                顯示名稱:</label>
            <input id="nc_downloader_display_name" name="DownloaderDisplayName" class="combo"
                style="width: 300px; height: 20px" />
        </div>
        <div class="fitem">
            <label>
                內容來源:</label>
            <input id="nc_content_source_url" name="ContentSourceUrl" class="combo" style="width: 300px;
                height: 20px" />
        </div>
        <div class="fitem">
            <label>
                HTTP種子:</label>
            <input id="nc_http_seed_url" name="HttpSeedsUrl" class="combo" style="width: 240px;
                height: 20px" />&nbsp;&nbsp;
            <input id="nc_same_to_content_src_url" type="checkbox" class="tree-checkbox" style="height: 20px" /><span>同上?</span>
        </div>
        <div class="fitem">
            <label>
                官網位址:</label>
            <input id="nc_downloader_home_url" name="DownloaderHomeUrl" class="combo" style="width: 300px;
                height: 20px" />
        </div>
        <div class="fitem">
            <label>
                FAQ位址:</label>
            <input id="nc_online_faq_url" name="OnlineFaqUrl" class="combo" style="width: 300px;
                height: 20px" />
        </div>
        <div class="fitem">
            <label>
                下載器圖示:</label>
            <input id="nc_icon_file" style="width: 300px; height: 20px" />
        </div>
        <div class="fitem">
            <label>
                免責聲明:</label>
            <input id="nc_disclaimer_file" style="width: 300px; height: 20px" />
        </div>
        <div class="ftitle">
            Google Analytics報表</div>
        <div class="fitem">
            <label>
                資源編號:</label>
            <input id="nc_ga_profile_id" name="GAProfileId" class="combo" style="width: 300px;
                height: 20px" />
        </div>
        <div class="ftitle">
            索取虛寶活動</div>
        <div class="fitem">
            <label>
                活動序號:</label>
            <input id="nc_promotion_event_id" name="PromotionEventID" class="combo" style="width: 300px;
                height: 20px" />
        </div>
        <div class="fitem">
            <label>
                活動伺服器:</label>
            <input id="nc_promotion_event_server_url" name="PromotionEventServerUrl" class="combo"
                style="width: 300px; height: 20px" />
        </div>
        <div class="ftitle">
            壓縮下載器</div>
        <div class="fitem">
            <label>
                是否壓縮?</label>
            <input id="nc_upx_compression" name="UPXCompression" type="checkbox" class="tree-checkbox"
                style="height: 20px" />
        </div>
        <input id="nc_content_hash_code" name="ContentHashCode" type="hidden" />
        </form>
    </div>
    <div id="nc_dlg_buttons">
        <a id="cmd_nc_confirm" href="#" class="easyui-linkbutton" iconcls="icon-ok">確 定</a>
        <a id="cmd_nc_cancel" href="#" class="easyui-linkbutton" iconcls="icon-cancel">取 消</a>
    </div>
    <!-- end of new content dialog box ui definitions -->
    <!-- begin of new version dialog box ui definitions -->
    <div id="nv_dlg" class="easyui-dialog" style="padding: 10px 25px; width: 500px; height: 450px;"
        title="建立新版本的下載內容物" buttons="#nv_dlg_buttons" iconcls="icon-blue-document" closed="true"
        shadow="true" modal="true">
        <form id="nv_form">
        <div class="ftitle">
            下載內容物</div>
        <div class="fitem">
            <label>
                內容代碼:</label>
            <input id="nv_content_id" class="combo" style="width: 240px; height: 20px" />&nbsp;&nbsp;
            <input id="nv_auto_deploy" type="checkbox" class="tree-checkbox" style="height: 20px" /><span>佈署?</span>
        </div>
        <div class="fitem">
            <label>
                顯示名稱:</label>
            <input id="nv_downloader_display_name" style="width: 300px; height: 20px" />
        </div>
        <div class="fitem">
            <label>
                內容來源:</label>
            <input id="nv_content_source_url" class="combo" style="width: 300px; height: 20px" />
        </div>
        <div class="fitem">
            <label>
                HTTP種子:</label>
            <input id="nv_http_seed_url" class="combo" style="width: 240px; height: 20px" />&nbsp;&nbsp;
            <input id="nv_same_to_content_src_url" type="checkbox" class="tree-checkbox" style="height: 20px" /><span>同上?</span>
        </div>
        <div class="fitem">
            <label>
                官網位址:</label>
            <input id="nv_downloader_home_url" style="width: 300px; height: 20px" />
        </div>
        <div class="fitem">
            <label>
                FAQ位址:</label>
            <input id="nv_online_faq_url" style="width: 300px; height: 20px" />
        </div>
        <div class="fitem">
            <label>
                下載器圖示:</label>
            <input id="nv_icon_file" style="width: 300px; height: 20px" />
        </div>
        <div class="fitem">
            <label>
                免責聲明:</label>
            <input id="nv_disclaimer_file" style="width: 300px; height: 20px" />
        </div>
        <div class="ftitle">
            Google Analytics報表</div>
        <div class="fitem">
            <label>
                資源編號:</label>
            <input id="nv_ga_profile_id" style="width: 300px; height: 20px" />
        </div>
        <div class="ftitle">
            索取虛寶活動</div>
        <div class="fitem">
            <label>
                活動序號:</label>
            <input id="nv_promotion_event_id" style="width: 300px; height: 20px" />
        </div>
        <div class="fitem">
            <label>
                活動伺服器:</label>
            <input id="nv_promotion_event_server_url" style="width: 300px; height: 20px" />
        </div>
        <div class="ftitle">
            壓縮下載器</div>
        <div class="fitem">
            <label>
                是否壓縮?</label>
            <input id="nv_upx_compression" type="checkbox" class="tree-checkbox" style="height: 20px" />
        </div>
        </form>
    </div>
    <div id="nv_dlg_buttons">
        <a id="cmd_nv_confirm" href="#" class="easyui-linkbutton" iconcls="icon-ok">確 定</a>
        <a id="cmd_nv_cancel" href="#" class="easyui-linkbutton" iconcls="icon-cancel">取 消</a>
    </div>
    <!-- end of new version dialog box ui definitions -->
</body>
<script type="text/javascript">
    $.messager.progress({
        title: '系統載入',
        msg: '畫面載入並進行初始化中, 請稍後...',
        text: '載入中...'
    });
</script>
<script type="text/javascript">
    function initSeedList() {
        // Seed List Panel
        $('#cmd_seed_refresh').linkbutton({ text: '', disabled: false, iconCls: 'icon-reload', plain: true });
        $('#tr_seed_list').tree({
            method: 'GET',
            url: 'CommandHandler.axd?cmd=query-seed-list&online=icon-dummy-happy&offline=icon-dummy-sad&torrent=icon-blue-document',
            onLoadError: function () {
                $.messager.progress('close');
                $.messager.alert('錯誤', 'Seed List Data Loading Failed', 'error');
            },
            onLoadSuccess: function (node, data) {
                $('#tr_seed_list').tree('collapseAll');
                $.messager.progress('close');
            },
            onBeforeSelect: function () {
                return false;
            }
        });
        $('#cmd_seed_refresh').click(function () {
            $.messager.progress({
                title: '資料同步',
                msg: '官方種子清單讀取中, 請稍後...',
                text: '讀取中...'
            });
            $('#tr_seed_list').tree('reload');
        });
    }
</script>
<script type="text/javascript">
    function initSysNotification() {
        // System Notification Panel
        $('#gd_notification_list').datagrid({
            border: false,
            fit: true,
            fitColumns: true,
            singleSelect: true,
            pagination: true,
            method: 'GET',
            url: 'CommandHandler.axd',
            queryParams: { cmd: 'query-sys-notification' },
            columns: [[
            { field: 'Time', title: '通知時間', width: 140, resizable: true },
            { field: 'Level', title: '通知類別', width: 60, resizable: true },
            { field: 'Message', title: '詳細內容', width: 800, resizable: true}]],
            rowStyler: function (inx, row) {
                if (row.Level == 'Error') return 'color:red'; else return '';
            },
            onLoadError: function () {
                $.messager.alert('錯誤', 'Sys Notification Data Loading Failed', 'error');
            },
            onSelect: function () {
                $('#gd_notification_list').datagrid('unselectAll');
            }
        });
    }
</script>
<script type="text/javascript">
    function initContentSummary() {
        // Content Summary
        $('#cmd_new_version').linkbutton({ text: '新增版本', disabled: true, iconCls: 'icon-blue-document-plus', plain: true });
        $('#gd_content_summary').datagrid({
            border: false,
            fit: true,
            fitColumns: false,
            singleSelect: true,
            noHeader: true,
            toolbar: '#tb_content_summary',
            pagination: false,
            method: 'GET',
            url: 'CommandHandler.axd',
            columns: [[
            { field: 'Name', title: '屬性', width: 100, resizable: true },
            { field: 'Value', title: '屬性值', width: 200, resizable: true }
        ]],
            rowStyler: function (inx, row) {
                if (row.Name == 'Name') { row.Name = '內容代碼'; return; }
                if (row.Name == 'DateCreated') { row.Name = '建立時間'; return; }
                if (row.Name == 'Count') { row.Name = '版本各數'; return; }
            },
            onBeforeLoad: function (p) {
                if (p.cmd == undefined) return false; else {
                    $('#gd_content_summary').datagrid('options').isLoading = true;
                    return true;
                }
            },
            onLoadError: function () {
                $('#cmd_new_version').linkbutton('disable');
                $.messager.alert('錯誤', 'load data failed', 'error');
                $('#gd_content_summary').datagrid('options').isLoading = false;
            },
            onLoadSuccess: function () {
                if ($(this).datagrid('getRows').length > 0) {
                    $('#cmd_new_version').linkbutton('enable');
                }
                else {
                    $('#cmd_new_version').linkbutton('disable');
                }
                $('#gd_content_summary').datagrid('options').isLoading = false;
            },
            onSelect: function () {
                $('#gd_content_summary').datagrid('unselectAll');
            }
        });
        $.extend($('#gd_content_summary').datagrid('options'), { isLoading: false });
        $('#cmd_new_version').click(function () {
            if ($(this).linkbutton('options').disabled == true) return false;
            var contentId = $('#tr_content_list').tree('find', $('#tr_content_list').tree('options').currentViewContentId).text;
            openNewVersionWindow(contentId);
        });
    }
</script>
<script type="text/javascript">
    // Work in Progress
    $('#cmd_interrupt_all').linkbutton({ text: '中斷', disabled: true, iconCls: 'icon-blue-document-minus', plain: true });
    $('#gd_work_in_progress').datagrid({
        border: false,
        fit: true,
        fitColumns: false,
        singleSelect: true,
        toolbar: '#tb_work_in_progress',
        pagination: false,
        method: 'GET',
        url: 'CommandHandler.axd',
        columns: [[
            { field: 'Time', title: '執行時間', width: 140, resizable: true },
            { field: 'Percentage', title: '完成度', width: 60, resizable: true, align: 'right' }
        ]],
        onBeforeLoad: function (p) {
            if (p.cmd == undefined) return false; else {
                $('#gd_work_in_progress').datagrid('options').isLoading = true;
                return true;
            }
        },
        onLoadError: function () {
            $('#cmd_interrupt_all').linkbutton('disable');
            $.messager.alert('錯誤', 'load data failed', 'error');
            $('#gd_work_in_progress').datagrid('options').isLoading = false;
        },
        onLoadSuccess: function () {
            if ($(this).datagrid('getRows').length > 0) {
                $('#cmd_interrupt_all').linkbutton('enable');
            }
            else {
                $('#cmd_interrupt_all').linkbutton('disable');
            }
            $('#gd_work_in_progress').datagrid('options').isLoading = false;
        },
        onSelect: function () {
            $('#gd_work_in_progress').datagrid('unselectAll');
        }
    });
    $.extend($('#gd_work_in_progress').datagrid('options'), { isLoading: false });
    $('#cmd_interrupt_all').click(function () {
        if ($(this).linkbutton('options').disabled == true) return false;
        var contentId = $('#tr_content_list').tree('find', $('#tr_content_list').tree('options').currentViewContentId).text;
        $.messager.progress({
            title: '指令執行',
            msg: '指令正在執行中, 請稍後...',
            text: '執行中...'
        });
        $.ajax({
            url: 'CommandHandler.axd',
            type: 'GET',
            data: {
                cmd: 'interrupt-content-gen',
                content_id: contentId
            }
        })
        .success(function (data, status) {
            setTimeout(function () {
                $.messager.progress('close');
                $('#gd_work_in_progress').datagrid('load', {
                    cmd: 'query-work-in-progress',
                    content_id: contentId
                });
            }, 1000);
        })
        .error(function (xhr) {
            $.messager.progress('close');
            $.messager.alert(
                '指令執行失敗',
                '<font color=\'red\'>錯誤代碼: ' + '(' + xhr.status + ') ' + xhr.statusText + '</font>',
                'error');
        });
    });
</script>
<script type="text/javascript">
    function initContentVersionList() {
        // Content Version List
        $('#cmd_deploy_content').linkbutton({ text: '佈署', disabled: true, iconCls: 'icon-blue-document-share', plain: true });
        $('#cmd_content_offline').linkbutton({ text: '下架', disabled: true, iconCls: 'icon-broom', plain: true });
        $('#cmd_pause_seeds').linkbutton({ text: '暫停', disabled: true, iconCls: 'icon-control-pause', plain: true });
        $('#cmd_resume_seeds').linkbutton({ text: '恢復', disabled: true, iconCls: 'icon-control', plain: true });
        $('#cmd_get_metafile').linkbutton({ text: '取得中介檔', disabled: true, iconCls: 'icon-drive-download', plain: true });
        $('#cmd_get_downloader').linkbutton({ text: '取得下載器', disabled: true, iconCls: 'icon-drive-download', plain: true });
        $('#cmd_regen_downloader').linkbutton({ text: '重建下載器', disabled: true, iconCls: 'icon-arrow-circle', plain: true });
        $('#gd_version_list').datagrid({
            border: false,
            fit: true,
            fitColumns: false,
            singleSelect: true,
            toolbar: '#tb_version_list',
            pagination: false,
            method: 'GET',
            url: 'CommandHandler.axd',
            idField: 'Hash',
            columns: [[
            { field: 'Time', title: '建立時間', width: 140, resizable: true },
            { field: 'Name', title: '檔案名稱', width: 200, resizable: true },
            { field: 'Hash', title: 'Hash值', width: 320, resizable: true },
            { field: 'DeployToTracker', title: '已發佈', width: 60, resizable: true, align: 'right' },
            { field: 'SeedDeploymentRatio', title: '佈署率', width: 60, resizable: true, align: 'right' },
            { field: 'SeedingRatio', title: '執行率', width: 60, resizable: true, align: 'right' }
        ]],
            rowStyler: function (inx, row) {
                if (row.DeployToTracker == true) row.DeployToTracker = '是'; else row.DeployToTracker = '否';
                row.SeedDeploymentRatio = (row.SeedDeploymentRatio * 100).toString() + '%';
                row.SeedingRatio = (row.SeedingRatio * 100).toString() + '%';
                if (row.SeedDeploymentRatio != '100%' || row.SeedingRatio != '100%') return 'color:red'; else return '';
            },
            onSelect: function (inx, row) {
                if ($('#tr_content_list').tree('find', $('#tr_content_list').tree('options').currentViewContentId) != null) {
                    var contentId = $('#tr_content_list').tree('find', $('#tr_content_list').tree('options').currentViewContentId).text;
                    $('#gd_version_list').datagrid('options').currentViewContentHash = row.Hash;
                    $('#gd_torrent_seed_detail').datagrid('load', {
                        cmd: 'query-torrent-seed-detail',
                        content_id: contentId,
                        content_hash: row.Hash
                    });
                }
            },
            onBeforeLoad: function (p) {
                if (p.cmd == undefined) return false; else {
                    $('#gd_version_list').datagrid('options').isLoading = true;
                    return true;
                }
            },
            onLoadError: function () {
                var dummyData = { "total": 0, "rows": [] };
                $('#gd_torrent_seed_detail').datagrid('loadData', dummyData);
                $('#cmd_deploy_content').linkbutton('disable');
                $('#cmd_content_offline').linkbutton('disable');
                $('#cmd_pause_seeds').linkbutton('disable');
                $('#cmd_resume_seeds').linkbutton('disable');
                $('#cmd_get_metafile').linkbutton('disable');
                $('#cmd_get_downloader').linkbutton('disable');
                $('#cmd_regen_downloader').linkbutton('disable');
                $.messager.alert('錯誤', 'load data failed', 'error');
                $('#gd_version_list').datagrid('options').isLoading = false;
            },
            onLoadSuccess: function () {
                if ($(this).datagrid('getRows').length > 0) {
                    if ($('#gd_version_list').datagrid('options').currentViewContentHash != '') {
                        var chash = $('#gd_version_list').datagrid('options').currentViewContentHash;
                        if ($('#gd_version_list').datagrid('getRowIndex', chash) < 0) {
                            $(this).datagrid('selectRow', 0);
                        }
                        else {
                            $('#gd_version_list').datagrid('selectRecord', chash);
                        }
                    }
                    else {
                        $(this).datagrid('selectRow', 0);
                    }
                    $('#cmd_deploy_content').linkbutton('enable');
                    $('#cmd_content_offline').linkbutton('enable');
                    $('#cmd_pause_seeds').linkbutton('enable');
                    $('#cmd_resume_seeds').linkbutton('enable');
                    $('#cmd_get_metafile').linkbutton('enable');
                    $('#cmd_get_downloader').linkbutton('enable');
                    $('#cmd_regen_downloader').linkbutton('enable');
                }
                else {
                    var dummyData = { "total": 0, "rows": [] };
                    $('#gd_torrent_seed_detail').datagrid('loadData', dummyData);
                    $('#cmd_deploy_content').linkbutton('disable');
                    $('#cmd_content_offline').linkbutton('disable');
                    $('#cmd_pause_seeds').linkbutton('disable');
                    $('#cmd_resume_seeds').linkbutton('disable');
                    $('#cmd_get_metafile').linkbutton('disable');
                    $('#cmd_get_downloader').linkbutton('disable');
                    $('#cmd_regen_downloader').linkbutton('disable');
                    $('#gd_version_list').datagrid('options').currentViewContentHash = '';
                }
                $('#gd_version_list').datagrid('options').isLoading = false;
            }
        });
        $.extend($('#gd_version_list').datagrid('options'), { isLoading: false });
        $.extend($('#gd_version_list').datagrid('options'), { currentViewContentHash: '' });
        $('#cmd_deploy_content').click(function () {
            $.messager.confirm(
                '指令執行提示',
                '確定要執行內容佈署作業指令?',
                function (bConfirm) {
                    if (bConfirm == true) {
                        doContentOperation($('#cmd_deploy_content'), 'deploy-content');
                    }
                }
            );
        });
        $('#cmd_content_offline').click(function () {
            $.messager.confirm(
                '指令執行提示',
                '確定要執行內容下架作業指令?',
                function (bConfirm) {
                    if (bConfirm == true) {
                        doContentOperation($('#cmd_content_offline'), 'content-offline');
                    }
                }
            );
        });
        $('#cmd_pause_seeds').click(function () {
            $.messager.confirm(
                '指令執行提示',
                '確定要執行內容暫停散播作業指令?',
                function (bConfirm) {
                    if (bConfirm == true) {
                        doContentOperation($('#cmd_pause_seeds'), 'pause-seeds');
                    }
                }
            );
        });
        $('#cmd_resume_seeds').click(function () {
            $.messager.confirm(
                '指令執行提示',
                '確定要執行內容恢復散播作業指令?',
                function (bConfirm) {
                    if (bConfirm == true) {
                        doContentOperation($('#cmd_resume_seeds'), 'resume-seeds');
                    }
                }
            );
        });
        $('#cmd_get_metafile').click(function () {
            if ($(this).linkbutton('options').disabled == true) return false;
            var contentId = $('#tr_content_list').tree('find', $('#tr_content_list').tree('options').currentViewContentId).text;
            var contentHash = $('#gd_version_list').datagrid('getSelected').Hash;
            if (contentId != '' && contentHash != '') {
                $.messager.progress({
                    title: '指令執行',
                    msg: '指令正在執行中, 請稍後...',
                    text: '執行中...'
                });
                // Evaluate if the command is successful first then download it later
                $.ajax({
                    url: 'CommandHandler.axd',
                    type: 'GET',
                    data: {
                        cmd: 'get-metafile',
                        content_id: contentId,
                        content_hash: contentHash
                    }
                })
                .success(function (data, status) {
                    setTimeout(function () {
                        $.messager.progress('close');
                        window.location.href = 'CommandHandler.axd?' + 'cmd=get-metafile' +
                                        '&content_id=' + encodeURIComponent(contentId) +
                                        '&content_hash=' + encodeURIComponent(contentHash);
                    }, 500);
                })
                .error(function (xhr) {
                    $.messager.progress('close');
                    $.messager.alert(
                        '指令執行失敗',
                        '<font color=\'red\'>錯誤代碼: ' + '(' + xhr.status + ') ' + xhr.statusText + '</font>',
                        'error');
                });
            }
        });
        $('#cmd_get_downloader').click(function () {
            if ($(this).linkbutton('options').disabled == true) return false;
            var contentId = $('#tr_content_list').tree('find', $('#tr_content_list').tree('options').currentViewContentId).text;
            var contentHash = $('#gd_version_list').datagrid('getSelected').Hash;
            if (contentId != '' && contentHash != '') {
                $.messager.progress({
                    title: '指令執行',
                    msg: '指令正在執行中, 請稍後...',
                    text: '執行中...'
                });
                // Evaluate if the command is successful first then download it later
                $.ajax({
                    url: 'CommandHandler.axd',
                    type: 'GET',
                    data: {
                        cmd: 'get-downloader',
                        content_id: contentId,
                        content_hash: contentHash
                    }
                })
                .success(function (data, status) {
                    setTimeout(function () {
                        $.messager.progress('close');
                        window.location.href = 'CommandHandler.axd?' + 'cmd=get-downloader' +
                                        '&content_id=' + encodeURIComponent(contentId) +
                                        '&content_hash=' + encodeURIComponent(contentHash);
                    }, 500);
                })
                .error(function (xhr) {
                    $.messager.progress('close');
                    $.messager.alert(
                        '指令執行失敗',
                        '<font color=\'red\'>錯誤代碼: ' + '(' + xhr.status + ') ' + xhr.statusText + '</font>',
                        'error');
                });
            }
        });
        $('#cmd_regen_downloader').click(function () {
            if ($(this).linkbutton('options').disabled == true) return false;
            var contentId = $('#tr_content_list').tree('find', $('#tr_content_list').tree('options').currentViewContentId).text;
            var contentHash = $('#gd_version_list').datagrid('getSelected').Hash;
            if (contentId != '' && contentHash != '') {
                openRegenDownloaderWindow(contentId, contentHash);
            }
        });
    }
    function doContentOperation(cmdButton, opCmd) {
        if ($(cmdButton).linkbutton('options').disabled == true) return false;
        var contentId = $('#tr_content_list').tree('find', $('#tr_content_list').tree('options').currentViewContentId).text;
        var contentHash = $('#gd_version_list').datagrid('getSelected').Hash;
        $.messager.progress({
            title: '指令執行',
            msg: '指令正在執行中, 請稍後...',
            text: '執行中...'
        });
        $.ajax({
            url: 'CommandHandler.axd',
            type: 'GET',
            data: {
                cmd: opCmd,
                content_id: contentId,
                content_hash: contentHash
            }
        })
        .success(function (data, status) {
            setTimeout(function () {
                $.messager.progress('close');
                $.messager.show({
                    title: '指令執行完成',
                    msg: '請刷新系統通知及內容清單以查看指令的執行結果.',
                    timeout: 3000,
                    showType: 'slide'
                });
            }, 500);
        })
        .error(function (xhr) {
            $.messager.progress('close');
            $.messager.alert(
                '指令執行失敗',
                '<font color=\'red\'>錯誤代碼: ' + '(' + xhr.status + ') ' + xhr.statusText + '</font>',
                'error');
        });
    }
</script>
<script type="text/javascript">
    function initTorrentSeedDetail() {
        // Torrent Seed Detail
        $('#gd_torrent_seed_detail').datagrid({
            border: false,
            fit: true,
            fitColumns: false,
            singleSelect: true,
            pagination: false,
            method: 'GET',
            url: 'CommandHandler.axd',
            columns: [[
            { field: 'IP', title: '官方種子', width: 80, resizable: true },
            { field: 'Size', title: '檔案大小', width: 100, resizable: true, align: 'right' },
            { field: 'Done', title: '完成度', width: 60, resizable: true, align: 'right' },
            { field: 'Status', title: '狀態', width: 100, resizable: true },
            { field: 'Error', title: '錯誤訊息', width: 500, resizable: true }
        ]],
            rowStyler: function (inx, row) {
                row.Size = (Math.round((row.Size * 100) / (1024 * 1024)) / 100).toString() + 'MB';
                row.Done = (Math.round(row.Done * 1000) / 10).toString() + '%';
                if (row.Status == 'Unknown') return 'color:red'; else return '';
            },
            onBeforeLoad: function (p) { if (p.cmd == undefined) return false; else return true; },
            onLoadError: function () {
                $.messager.alert('錯誤', 'load data failed', 'error');
            },
            onSelect: function () {
                $('#gd_torrent_seed_detail').datagrid('unselectAll');
            }
        });
    }
</script>
<script type="text/javascript">
    function initContentList() {
        // Content List Panel
        $('#cmd_content_refresh').linkbutton({ text: '', disabled: false, iconCls: 'icon-reload', plain: true });
        $('#cmd_new_content').linkbutton({ text: '新增內容', disabled: false, iconCls: 'icon-blue-document-plus', plain: true });
        $('#tr_content_list').tree({
            method: 'GET',
            url: 'CommandHandler.axd?cmd=query-content-list&online=icon-blue-document&offline=icon-blue-document-exclamation',
            onSelect: function (node) {
                $('#tr_content_list').tree('options').currentViewContentId = node.id;
                if ($('#gd_content_summary').datagrid('options').isLoading == false) {
                    $('#gd_content_summary').datagrid('load', {
                        cmd: 'query-content-summary',
                        content_id: node.text
                    });
                }
                if ($('#gd_work_in_progress').datagrid('options').isLoading == false) {
                    $('#gd_work_in_progress').datagrid('load', {
                        cmd: 'query-work-in-progress',
                        content_id: node.text
                    });
                }
                if ($('#gd_version_list').datagrid('options').isLoading == false) {
                    $('#gd_version_list').datagrid('load', {
                        cmd: 'query-version-list',
                        content_id: node.text
                    });
                }
                //var panelFocus = $('#ac_content_detail').accordion('getSelected');
                //if (panelFocus != null && panelFocus.panel('options').title == 'Version Status') {
                //    $('#ac_content_detail').accordion('select', 'Version List');
                //}
            },
            onLoadError: function () {
                $.messager.progress('close');
                var dummyData = { "total": 0, "rows": [] };
                $('#gd_content_summary').datagrid('loadData', dummyData);
                $('#gd_work_in_progress').datagrid('loadData', dummyData);
                $('#gd_version_list').datagrid('loadData', dummyData);
                $('#gd_torrent_seed_detail').datagrid('loadData', dummyData);
                $.messager.alert('錯誤', 'load data failed', 'error');
            },
            onLoadSuccess: function (node, data) {
                $.messager.progress('close');
                if ($('#tr_content_list').tree('options').currentViewContentId != '') {
                    var cid = $('#tr_content_list').tree('options').currentViewContentId;
                    var n = $('#tr_content_list').tree('find', cid);
                    if (n != null) {
                        $('#tr_content_list').tree('select', n.target);
                    }
                    else {
                        var dummyData = { "total": 0, "rows": [] };
                        $('#gd_content_summary').datagrid('loadData', dummyData);
                        $('#gd_work_in_progress').datagrid('loadData', dummyData);
                        $('#gd_version_list').datagrid('loadData', dummyData);
                        $('#gd_torrent_seed_detail').datagrid('loadData', dummyData);
                    }
                }
            }
        });
        $.extend($('#tr_content_list').tree('options'), { currentViewContentId: '' });
        $('#cmd_content_refresh').click(function () {
            $.messager.progress({
                title: '資料同步',
                msg: '內容清單讀取中, 請稍後...',
                text: '讀取中...'
            });
            $('#tr_content_list').tree('reload');
        });
        $('#cmd_new_content').click(function () {
            openNewContentWindow();
        });
    }
</script>
<script type="text/javascript">
    function initNewContentDlg() {
        // New Content Dialog
        $('#nc_content_id').validatebox({
            required: true
        });
        $('#nc_downloader_display_name').validatebox({
            required: true
        });
        $('#nc_content_source_url').validatebox({
            required: true,
            validType: 'url'
        });
        $('#nc_http_seed_url').validatebox({
            required: false,
            validType: 'url'
        });
        $('#nc_downloader_home_url').validatebox({
            required: true,
            validType: 'url'
        });
        $('#nc_online_faq_url').validatebox({
            required: true,
            validType: 'url'
        });
        $('#nc_icon_file').combobox({
            required: true,
            valueField: 'id',
            textField: 'text',
            mode: 'remote',
            method: 'GET',
            formatter: function (row) {
                return '<span class="item-text">' + $('<div/>').text(row.text).html() + '</span>';
            }
        });
        $('#nc_disclaimer_file').combobox({
            required: true,
            valueField: 'id',
            textField: 'text',
            mode: 'remote',
            method: 'GET',
            formatter: function (row) {
                return '<span class="item-text">' + $('<div/>').text(row.text).html() + '</span>';
            }
        });
        $('#nc_ga_profile_id').validatebox({
            required: true
        });
        $('#nc_promotion_event_id').validatebox({
            required: false
        });
        $('#nc_promotion_event_server_url').validatebox({
            required: false,
            validType: 'url'
        });
        $('#nc_content_source_url').change(function () {
            if ($('#nc_same_to_content_src_url').prop('checked') == true) {
                $('#nc_http_seed_url').val($('#nc_content_source_url').val());
            }
        });
        $('#nc_same_to_content_src_url').change(function () {
            if ($('#nc_same_to_content_src_url').prop('checked') == true) {
                $('#nc_http_seed_url').val($('#nc_content_source_url').val());
                $('#nc_http_seed_url').prop('disabled', true);
            }
            else {
                $('#nc_http_seed_url').val('');
                $('#nc_http_seed_url').prop('disabled', false);
            }
        });
        $('#nc_promotion_event_id').change(function () {
            if ($('#nc_promotion_event_id').val().length > 0) {
                $('#nc_promotion_event_server_url').prop('disabled', false);
            }
            else {
                $('#nc_promotion_event_server_url').val('');
                $('#nc_promotion_event_server_url').prop('disabled', true);
            }
        });
        $('#cmd_nc_confirm').click(function () {
            confirmNewContentWindow();
        });
        $('#cmd_nc_cancel').click(function () {
            cancelNewContentWindow();
        });
    }
</script>
<script type="text/javascript">
    function initNewVersionDlg() {
        // New Version Dialog
        $('#nv_content_id').validatebox({
            required: true
        });
        $('#nv_downloader_display_name').combobox({
            required: true,
            valueField: 'id',
            textField: 'text',
            mode: 'remote',
            method: 'GET',
            formatter: function (row) {
                return '<span class="item-text">' + $('<div/>').text(row.text).html() + '</span>';
            }
        });
        $('#nv_content_source_url').validatebox({
            required: true,
            validType: 'url'
        });
        $('#nv_http_seed_url').validatebox({
            required: false,
            validType: 'url'
        });
        $('#nv_downloader_home_url').combobox({
            required: true,
            validType: 'url',
            valueField: 'id',
            textField: 'text',
            mode: 'remote',
            method: 'GET',
            formatter: function (row) {
                return '<span class="item-text">' + $('<div/>').text(row.text).html() + '</span>';
            }
        });
        $('#nv_online_faq_url').combobox({
            required: true,
            validType: 'url',
            valueField: 'id',
            textField: 'text',
            mode: 'remote',
            method: 'GET',
            formatter: function (row) {
                return '<span class="item-text">' + $('<div/>').text(row.text).html() + '</span>';
            }
        });
        $('#nv_icon_file').combobox({
            required: true,
            valueField: 'id',
            textField: 'text',
            mode: 'remote',
            method: 'GET',
            formatter: function (row) {
                return '<span class="item-text">' + $('<div/>').text(row.text).html() + '</span>';
            }
        });
        $('#nv_disclaimer_file').combobox({
            required: true,
            valueField: 'id',
            textField: 'text',
            mode: 'remote',
            method: 'GET',
            formatter: function (row) {
                return '<span class="item-text">' + $('<div/>').text(row.text).html() + '</span>';
            }
        });
        $('#nv_ga_profile_id').combobox({
            required: true,
            valueField: 'id',
            textField: 'text',
            mode: 'remote',
            method: 'GET',
            formatter: function (row) {
                return '<span class="item-text">' + $('<div/>').text(row.text).html() + '</span>';
            }
        });
        $('#nv_promotion_event_id').combobox({
            required: false,
            valueField: 'id',
            textField: 'text',
            mode: 'remote',
            method: 'GET',
            formatter: function (row) {
                return '<span class="item-text">' + $('<div/>').text(row.text).html() + '</span>';
            }
        });
        $('#nv_promotion_event_server_url').combobox({
            required: false,
            validType: 'url',
            valueField: 'id',
            textField: 'text',
            mode: 'remote',
            method: 'GET',
            formatter: function (row) {
                return '<span class="item-text">' + $('<div/>').text(row.text).html() + '</span>';
            }
        });
        $('#nv_content_source_url').change(function () {
            if ($('#nv_same_to_content_src_url').prop('checked') == true) {
                $('#nv_http_seed_url').val($('#nv_content_source_url').val());
            }
        });
        $('#nv_same_to_content_src_url').change(function () {
            if ($('#nv_same_to_content_src_url').prop('checked') == true) {
                $('#nv_http_seed_url').val($('#nv_content_source_url').val());
                $('#nv_http_seed_url').prop('disabled', true);
            }
            else {
                $('#nv_http_seed_url').val('');
                $('#nv_http_seed_url').prop('disabled', false);
            }
        });
        $('#nv_promotion_event_id').combobox({ onChange: function () {
            if ($('#nv_promotion_event_id').combobox('getValue').length > 0) {
                $('#nv_promotion_event_server_url').combobox('enable');
            }
            else {
                $('#nv_promotion_event_server_url').combobox('setValue', '');
                $('#nv_promotion_event_server_url').combobox('disable');
            }
        }
        });
        $('#cmd_nv_confirm').click(function () {
            confirmNewVersionWindow();
        });
        $('#cmd_nv_cancel').click(function () {
            cancelNewVersionWindow();
        });
    }
</script>
<script type="text/javascript">
    var marqueeIndx = 0;
    function onload() {
        $('#portal_banner').html('&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;');
        setTimeout(function () {
            $('#portal_banner').text($('#portal_banner').text() + document.title.substr(marqueeIndx++, 1));
            if (marqueeIndx < document.title.length) setTimeout(arguments.callee, 10);
        }, 10);
        //
        initNewContentDlg();
        initNewVersionDlg();
        //
        initContentSummary();
        initContentVersionList();
        initTorrentSeedDetail();
        $.messager.progress('close');
        // Transformer does the final initializations
        setTimeout(function () {
            // Step 1
            initSeedList();
            setTimeout(function () {
                // Step 2
                initContentList();
                setTimeout(function () {
                    // Step 3
                    initSysNotification();
                    setTimeout(function () {
                        // Step 4, Adjust the Layout of the Dashboard
                        $('#main_dashboard').layout();
                        setTimeout(function () {
                            // Step 5, Collapse the System Notification Panel   
                            $('#main_dashboard').layout('collapse', 'south');
                            setTimeout(function () {
                                // Step 6
                                $.messager.show({
                                    title: '系統載入成功',
                                    msg: '系統載入成功.',
                                    timeout: 3000,
                                    showType: 'slide'
                                });
                            }, 500);
                        }, 500);
                    }, 500);
                }, 500);
            }, 500);
        }, 500);
    }

    function openNewContentWindow() {
        $('#nc_dlg').dialog('setTitle', '建立新的下載內容物');
        $('#nc_form').form('clear');
        //
        $('#nc_form').form('load', 'CommandHandler.axd?cmd=query-default-values');
        // New Content Dialog
        $('#nc_content_id').prop('disabled', false);
        $('#nc_content_source_url').prop('disabled', false);
        $('#nc_http_seed_url').prop('disabled', true);
        $('#nc_promotion_event_server_url').prop('disabled', true);
        //
        $('#nc_auto_deploy').prop('checked', true);
        $('#nc_auto_deploy').prop('disabled', false);
        $('#nc_same_to_content_src_url').prop('checked', true);
        $('#nc_same_to_content_src_url').prop('disabled', false);
        $('#nc_upx_compression').prop('checked', true);
        //
        $('#nc_icon_file').combobox(
            'reload',
            'CommandHandler.axd?cmd=query-icon-file');
        //
        $('#nc_disclaimer_file').combobox(
            'reload',
            'CommandHandler.axd?cmd=query-disclaimer-file');
        //
        $('#nc_dlg').dialog('open');
        $('#nc_form').form('validate');
    }

    function confirmNewContentWindow() {
        if ($('#nc_form').form('validate') == false) return;
        doContentGen(
            $('#nc_content_id').val(),
            $.toJSON({
                AutoDeploy: $('#nc_auto_deploy').prop('checked'),
                ContentSourceUrl: $('#nc_content_source_url').val(),
                HttpSeedsUrl: $('#nc_http_seed_url').val(),
                VipHttpSeedsUrl: '',
                DownloaderDisplayName: $('#nc_downloader_display_name').val(),
                DownloaderHomeUrl: $('#nc_downloader_home_url').val(),
                OnlineFaqUrl: $('#nc_online_faq_url').val(),
                IconFile: $('#nc_icon_file').combobox('getText'),
                DisclaimerFile: $('#nc_disclaimer_file').combobox('getText'),
                GAProfileId: $('#nc_ga_profile_id').val(),
                PromotionEventID: $('#nc_promotion_event_id').val(),
                PromotionEventServerUrl: $('#nc_promotion_event_server_url').val(),
                UPXCompression: $('#nc_upx_compression').prop('checked'),
                ContentHashCode: $('#nc_content_hash_code').val()
            }));
        $('#nc_dlg').dialog('close');
    }

    function cancelNewContentWindow() {
        $('#nc_dlg').dialog('close');
    }

    function openNewVersionWindow(contentId) {
        $('#nv_form').form('clear');
        // New Version Dialog
        $('#nv_content_id').prop('value', contentId);
        $('#nv_http_seed_url').prop('disabled', true);
        $('#nv_promotion_event_server_url').combobox('disable');
        $('#nv_auto_deploy').prop('checked', true);
        $('#nv_same_to_content_src_url').prop('checked', true);
        $('#nv_upx_compression').prop('checked', true);
        //
        $('#nv_downloader_display_name').combobox(
            'reload',
            'CommandHandler.axd?cmd=query-display-name&content_id=' + contentId);
        $('#nv_downloader_home_url').combobox(
            'reload',
            'CommandHandler.axd?cmd=query-home-url&content_id=' + contentId);
        $('#nv_online_faq_url').combobox(
            'reload',
            'CommandHandler.axd?cmd=query-online-faq-url&content_id=' + contentId);
        $('#nv_icon_file').combobox(
            'reload',
            'CommandHandler.axd?cmd=query-icon-file');
        $('#nv_disclaimer_file').combobox(
            'reload',
            'CommandHandler.axd?cmd=query-disclaimer-file');
        $('#nv_ga_profile_id').combobox(
            'reload',
            'CommandHandler.axd?cmd=query-ga-profile-id&content_id=' + contentId);
        $('#nv_promotion_event_id').combobox(
            'reload',
            'CommandHandler.axd?cmd=query-promo-event-id&content_id=' + contentId);
        $('#nv_promotion_event_server_url').combobox(
            'reload',
            'CommandHandler.axd?cmd=query-promo-event-server-url&content_id=' + contentId);
        //
        $('#nv_dlg').dialog('open');
        $('#nv_form').form('validate');
        // Disable the mandatory textboxs after invoking form validation to it work properly in IE
        $('#nv_content_id').prop('disabled', true);
    }

    function confirmNewVersionWindow() {
        if ($('#nv_form').form('validate') == false) return;
        doContentGen(
            $('#nv_content_id').val(),
            $.toJSON({
                AutoDeploy: $('#nv_auto_deploy').prop('checked'),
                ContentSourceUrl: $('#nv_content_source_url').val(),
                HttpSeedsUrl: $('#nv_http_seed_url').val(),
                VipHttpSeedsUrl: '',
                DownloaderDisplayName: $('#nv_downloader_display_name').combobox('getText'),
                DownloaderHomeUrl: $('#nv_downloader_home_url').combobox('getText'),
                OnlineFaqUrl: $('#nv_online_faq_url').combobox('getText'),
                IconFile: $('#nv_icon_file').combobox('getText'),
                DisclaimerFile: $('#nv_disclaimer_file').combobox('getText'),
                GAProfileId: $('#nv_ga_profile_id').combobox('getText'),
                PromotionEventID: $('#nv_promotion_event_id').combobox('getText'),
                PromotionEventServerUrl: $('#nv_promotion_event_server_url').combobox('getText'),
                UPXCompression: $('#nv_upx_compression').prop('checked')
            }));
        $('#nv_dlg').dialog('close');
    }

    function cancelNewVersionWindow() {
        $('#nv_dlg').dialog('close');
    }

    function openRegenDownloaderWindow(contentId, contentHash) {
        $('#nc_dlg').dialog('setTitle', '重新產生下載器');
        $('#nc_form').form('clear');
        // Re-gen Downloader Dialog based on New Content Dialog
        $('#nc_content_id').prop('value', contentId);
        $('#nc_content_hash_code').prop('value', contentHash);
        $('#nc_content_source_url').prop('disabled', true);
        $('#nc_http_seed_url').prop('disabled', true);
        $('#nc_promotion_event_server_url').prop('disabled', true);
        //
        $('#nc_auto_deploy').prop('checked', true);
        $('#nc_auto_deploy').prop('disabled', true);
        $('#nc_same_to_content_src_url').prop('checked', true);
        $('#nc_same_to_content_src_url').prop('disabled', true);
        $('#nc_upx_compression').prop('checked', true);
        //
        $('#nc_icon_file').combobox(
            'reload',
            'CommandHandler.axd?cmd=query-icon-file');
        //
        $('#nc_disclaimer_file').combobox(
            'reload',
            'CommandHandler.axd?cmd=query-disclaimer-file');
        //
        $('#nc_dlg').dialog('open');
        $('#nc_form').form('validate');
        // Disable the mandatory textboxs after invoking form validation to it work properly in IE
        $('#nc_content_id').prop('disabled', true);
        //
        var resultAjax = $.ajax({
            url: 'CommandHandler.axd',
            type: 'GET',
            data: {
                cmd: 'query-content-recipes',
                content_id: contentId,
                content_hash: contentHash
            }
        })
        .success(function (data, status) {
            // Do the form binding to the returned JSON
            $('#nc_form').form('load', data);
            // Form binding not work for Checkbox. Here is the workaround.
            if (data.UPXCompression == true) {
                $('#nc_upx_compression').prop('checked', true);
            } else {
                $('#nc_upx_compression').prop('checked', false);
            }
        })
        .error(function (xhr) {
            $.messager.alert('錯誤', 'load data failed', 'error');
        });
    }

    function doContentGen(contentId, contentRecipes) {
        $.messager.progress({
            title: '指令執行',
            msg: '指令正在執行中, 請稍後...',
            text: '執行中...'
        });
        var resultAjax = $.ajax({
            url: 'CommandHandler.axd',
            type: 'GET',
            data: {
                cmd: 'content-gen',
                content_id: contentId,
                content_gen_recipes: contentRecipes
            }
        })
        .success(function (data, status) {
            setTimeout(function () {
                $.messager.progress('close');
                $.messager.show({
                    title: '指令執行完成',
                    msg: '請刷新系統通知及內容清單以查看指令的執行結果.',
                    timeout: 3000,
                    showType: 'slide'
                });
            }, 500);
        })
        .error(function (xhr) {
            $.messager.progress('close');
            $.messager.alert(
                '指令執行失敗',
                '<font color=\'red\'>錯誤代碼: ' + '(' + xhr.status + ') ' + xhr.statusText + '</font>',
                'error');
        });
    }
</script>
</html>
