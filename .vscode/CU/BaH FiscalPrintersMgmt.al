codeunit 50000 "BaH FiscalPrintersMgmt"
{
    // BH1.00, Fiscal Process


    trigger OnRun()
    begin
    end;

    var
        ERROR_NO_PRINTER: Label 'Ne postoji printer %1!';
        ERROR_NOT_IMPLEMENTED: Label 'Ova funkcija nije implementirana za odabrani printer!';
    // Tremol: Report "BaH TREMOL";
    //ErpT260F: Report "BaH ERP-T260F";
    //ErpT260FSQL: Report "BaH ERP-T260F-SQL";
    //ĐKTringHttp: Report "50009";
    //ĐK Mehrs: Report "50010";

    procedure PrintInvoiceFromSalesHeader(var SalesHeader: Record "Sales Header")
    var
        FiscalPrinter: Code[10];
    begin
    end;

    procedure PrintInvoiceFromSalesInvHeader(var SalesHeader: Record "Sales Invoice Header")
    var
        FiscalPrinter: Code[10];
    begin
        FiscalPrinter := GetFiscalPrinter;

        CASE FiscalPrinter OF
        /*'TRINGHTTP':TringHttp.PrintInvoiceFromSalesInvHeader(SalesHeader);
        'TREMOL':Tremol.PrintInvoiceFromSalesInvHeader(SalesHeader);
       //đk 'MEHRS':Mehrs.PrintInvoiceFromSalesInvHeader(SalesHeader);
        'ERP-T260F':ErpT260F.PrintInvoiceFromSalesInvHeader(SalesHeader);
        'ERPT26FSQL':ErpT260FSQL.PrintInvoiceFromSalesInvHeader(SalesHeader);
        ELSE ERROR(ERROR_NO_PRINTER, FiscalPrinter);*/
        END;
    end;

    procedure PrintCreditMemoFromCrMemoHead(var SalesHeader: Record "Sales Cr.Memo Header")
    var
        FiscalPrinter: Code[10];
    begin
        FiscalPrinter := GetFiscalPrinter;

        CASE FiscalPrinter OF
        /* 'TRINGHTTP':TringHttp.PrintCreditMemoFromCrMemoHead(SalesHeader);
         'TREMOL':Tremol.PrintCreditMemoFromCrMemoHead(SalesHeader);
         'MEHRS':Mehrs.PrintCreditMemoFromCrMemoHead(SalesHeader);
         'ERP-T260F':ErpT260F.PrintCreditMemoFromCrMemoHead(SalesHeader);
         'ERPT26FSQL':ErpT260FSQL.PrintCreditMemoFromCrMemoHead(SalesHeader);
         ELSE ERROR(ERROR_NO_PRINTER, FiscalPrinter);*/
        END;
    end;

    procedure PrintCreditMemoFromSalesHeader(var SalesHeader: Record "Sales Header")
    var
        FiscalPrinter: Code[10];
    begin
    end;

    procedure DailyReport()
    var
        FiscalPrinter: Code[10];
    begin
        FiscalPrinter := GetFiscalPrinter;

        CASE FiscalPrinter OF
        /*'TRINGHTTP':TringHttp.DailyReport;
        'TREMOL':Tremol.DailyReport;
        'MEHRS':Mehrs.DailyReport;
        'ERP-T260F':ErpT260F.DailyReport;
        'ERPT26FSQL':ErpT260FSQL.DailyReport;
        ELSE ERROR(ERROR_NO_PRINTER, FiscalPrinter);*/
        END;
    end;

    procedure Void()
    var
        FiscalPrinter: Code[10];
    begin
        FiscalPrinter := GetFiscalPrinter;

        CASE FiscalPrinter OF
        /*   'TRINGHTTP':TringHttp.Void;
           'TREMOL':Tremol.Void;
           'MEHRS':Mehrs.Void;
           'ERP-T260F':ErpT260F.Void;
           'ERPT26FSQL':ErpT260FSQL.Void;
           ELSE ERROR(ERROR_NO_PRINTER, FiscalPrinter);*/
        END;
    end;

    procedure Deposit(Amount: Decimal)
    var
        FiscalPrinter: Code[10];
    begin
        FiscalPrinter := GetFiscalPrinter;

        CASE FiscalPrinter OF
        /*   'TRINGHTTP':TringHttp.Deposit(Amount);
           'TREMOL':Tremol.Deposit(Amount);
           'MEHRS':Mehrs.Deposit(Amount);
           'ERP-T260F':ErpT260F.Deposit(Amount);
           'ERPT26FSQL':ErpT260FSQL.Deposit(Amount);
           ELSE ERROR(ERROR_NO_PRINTER, FiscalPrinter);*/
        END;
    end;

    procedure CashOut(Amount: Decimal)
    var
        FiscalPrinter: Code[10];
    begin
        FiscalPrinter := GetFiscalPrinter;

        CASE FiscalPrinter OF
        /* 'TRINGHTTP':TringHttp.CashOut(Amount);
         'TREMOL':Tremol.CashOut(Amount);
         'MEHRS':Mehrs.CashOut(Amount);
         'ERP-T260F':ErpT260F.CashOut(Amount);
         'ERPT26FSQL':ErpT260FSQL.CashOut(Amount);
         ELSE ERROR(ERROR_NO_PRINTER, FiscalPrinter);*/
        END;
    end;

    procedure PeriodReport(FromDate: Date; ToDate: Date)
    var
        FiscalPrinter: Code[10];
    begin
        FiscalPrinter := GetFiscalPrinter;

        CASE FiscalPrinter OF
        /*  'TRINGHTTP':TringHttp.PeriodReport(FromDate,ToDate);
          'TREMOL':Tremol.PeriodReport(FromDate,ToDate);
          'MEHRS':Mehrs.PeriodReport(FromDate,ToDate);
          'ERP-T260F':ErpT260F.PeriodReport(FromDate,ToDate);
          'ERPT26FSQL':ErpT260FSQL.PeriodReport(FromDate,ToDate);
          ELSE ERROR(ERROR_NO_PRINTER, FiscalPrinter);*/
        END;
    end;

    procedure PrintInvoiceDuplicate(FromDateTime: DateTime; ToDateTime: DateTime; InvoiceNo: Integer)
    var
        FiscalPrinter: Code[10];
    begin
        FiscalPrinter := GetFiscalPrinter;

        CASE FiscalPrinter OF
        /*'TRINGHTTP':TringHttp.PrintInvoiceDuplicate(FromDateTime,ToDateTime,InvoiceNo);
        'TREMOL':Tremol.PrintInvoiceDuplicate(FromDateTime,ToDateTime,InvoiceNo);
        'MEHRS':Mehrs.PrintInvoiceDuplicate(FromDateTime,ToDateTime,InvoiceNo);
        'ERP-T260F':ErpT260F.PrintInvoiceDuplicate(FromDateTime,ToDateTime,InvoiceNo);
        'ERPT26FSQL':ErpT260FSQL.PrintInvoiceDuplicate(FromDateTime,ToDateTime,InvoiceNo);
        ELSE ERROR(ERROR_NO_PRINTER, FiscalPrinter);*/
        END;
    end;

    procedure DeleteItemDB()
    var
        FiscalPrinter: Code[10];
    begin
        FiscalPrinter := GetFiscalPrinter;

        CASE FiscalPrinter OF
            'TRINGHTTP':
                ERROR(ERROR_NOT_IMPLEMENTED);
            //'TREMOL':Tremol.DeleteItemDB;
            ELSE
                ERROR(ERROR_NO_PRINTER, FiscalPrinter);
        END;
    end;

    procedure GetFiscalPrinter() FiscalPrinter: Code[10]
    var
        FiscalPrinterSetup: Record "BaH Fiscal Printer Setup";
        UserSetup: Record "BaH Fiscal User Setup";
        UserPrinter: Code[10];
    begin
        UserSetup.GET(USERID);
        UserSetup.TESTFIELD("Fiscal Printer Code");
        UserPrinter := UserSetup."Fiscal Printer Code";
        FiscalPrinterSetup.GET(UserPrinter);
        FiscalPrinter := FiscalPrinterSetup.Type;
    end;
}

