report 50379 "Purchase VAT Book-Advance"
{
    // BH1.00, VAT Books
    DefaultLayout = RDLC;
    RDLCLayout = './Purchase VAT Book-Advance.rdl';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {
        dataitem(DataItem1; "VAT Entry")
        {
            DataItemTableView = SORTING("Posting Date", "Document No.")
                                ORDER(Ascending)
                                WHERE(Type = CONST(Purchase),
                                      Import = FILTER(false));
            PrintOnlyIfDetail = true;
            RequestFilterFields = "Posting Date";
            column(ReportCaption; ReportCaption)
            {
            }
            column(ReportFilters; ReportFilters)
            {
            }
            column(CompanyName; CompInfo.Name)
            {
            }
            column(CompVATNo; CompInfo."VAT Registration No.")
            {
                IncludeCaption = true;
            }
            column(TodayFormatted; FORMAT(TODAY))
            {
            }
            column(PageNoCaption; PageNoCaptionLbl)
            {
            }
            column(DocumentNo; "Document No.")
            {
                IncludeCaption = true;
            }
            column(VendorOrder; VendorOrder)
            {
            }
            column(VendorOrderCaption; VendorOrderCaption)
            {
            }
            column(ExternalDocumentNo; "External Document No.")
            {
                IncludeCaption = true;
            }
            column(PostingDate; "Posting Date")
            {
                IncludeCaption = true;
            }
            column(AmountRetro; "VAT Amount (retro.)")
            {
            }
            column(VendorName; Vendor.Name + ', ' + Vendor.City)
            {
            }
            column(VATRegistrationNo; "VAT Registration No.")
            {
                IncludeCaption = true;
            }
            column(jci; jci)
            {
            }
            column(CounterCaption; CounterCaption)
            {
            }
            column(VendorCaption; VendorCaption)
            {
            }
            column(Amountr; Amountr)
            {
            }

            column(Column1Caption; Column1Caption)
            {
            }
            column(Column2Caption; Column2Caption)
            {
            }
            column(Column3Caption; Column3Caption)
            {
            }
            column(Column4Caption; Column4Caption)
            {
            }
            column(Column5Caption; Column5Caption)
            {
            }
            column(Column6Caption; Column6Caption)
            {
            }
            column(HeaderDocumentCaption; HeaderDocumentCaption)
            {
            }
            column(HeaderVendorCaption; HeaderVendorCaption)
            {
            }
            column(HeaderVATCaption; HeaderVATCaption)
            {
            }
            column(TotalCaption; TotalCaption)
            {
            }
            column(VATdate; "VAT Date")
            {
            }
            column(FV; "Full VAT")
            {
            }
            column(No; DataItem1."Total Entry No.")
            {
            }
            dataitem(DataItem2; "Detailed VAT Entry")
            {
                DataItemLink = "VAT Entry No." = FIELD("Entry No."),
                               Type = FIELD(Type);
                DataItemTableView = SORTING("VAT Entry No.")
                                    ORDER(Ascending);
                column(Column1; Column1)
                {
                }
                column(Column2; Column2)
                {
                }
                column(Column3; Column3)
                {
                }
                column(Column4; Column4)
                {
                }
                column(Column5; Column5)
                {
                }
                column(Column6; Column6)
                {
                }

                trigger OnAfterGetRecord()
                begin
                    IF
                      (Column1 = 0) AND
                      (Column2 = 0) AND
                      (Column3 = 0) AND
                      (Column4 = 0) AND
                      (Column5 = 0) AND
                      (Column6 = 0)
                    THEN
                        CurrReport.SKIP;
                    CALCFIELDS("Amount retro");
                end;
            }

            trigger OnAfterGetRecord()
            var
                PIH2: Record "Purch. Inv. Header";
                ve: Record "VAT Entry";
                ve2: Record "VAT Entry";
            begin
                IF NOT Vendor.GET("Bill-to/Pay-to No.") THEN BEGIN
                    Vendor.INIT;
                    Vendor.Name := CompInfo.Name;
                    "VAT Registration No." := CompInfo."VAT Registration No.";
                END;
                //Amountr:=0;

                ve.SETFILTER("Document No.", '%1', "Document No.");
                ve.SETFILTER("VAT Calculation Type", '%1', "VAT Calculation Type"::"Full VAT");
                IF ve.FIND('-') THEN BEGIN
                    jci := ve."VAT Amount (retro.)";
                    ve.CALCFIELDS("Total Entry No.");
                    IF ve."Total Entry No." <> 0 THEN
                        Amountr += (ve."VAT Amount (retro.)" / ve."Total Entry No.");
                END
                ELSE BEGIN
                    jci := 0;
                    Amountr := 0;
                END

                /*ve2.SETFILTER("Document No.",'%1',"Document No.");
                ve2.SETFILTER("VAT Calculation Type",'%1',ve2."VAT Calculation Type"::"Full VAT");
                IF ve2.FIND('-') THEN  BEGIN
                Amountr:=ve2.COUNT;
                 END;
                //UNTIL ve2.NEXT=0;   */

            end;

            trigger OnPreDataItem()
            begin
                VendorOrder := '';
                SETFILTER("Document No.", '%1|%2', 'PAF*', 'CPAF*');
            end;
        }
    }

    requestpage
    {

        layout
        {
        }

        actions
        {
        }
    }

    labels
    {
    }

    trigger OnPreReport()
    begin
        CompInfo.GET;
        ReportFilters := DataItem1.GETFILTERS;
    end;

    var
        CompInfo: Record "Company Information";
        Vendor: Record Vendor;
        ReportCaption: Label 'Purchase VAT Book';
        PageNoCaptionLbl: Label 'Page';
        CounterCaption: Label 'No.';
        VendorCaption: Label 'Name, City';
        Column1Caption: Label 'Amount excl. VAT';
        Column2Caption: Label 'Amount incl. VAT';
        Column3Caption: Label 'Flat fee';
        Column4Caption: Label 'Total';
        Column5Caption: Label 'Deductable';
        Column6Caption: Label 'Nondeductable';
        HeaderDocumentCaption: Label 'Document';
        HeaderVendorCaption: Label 'Vendor';
        HeaderVATCaption: Label 'VAT';
        TotalCaption: Label 'Total';
        ReportFilters: Text[1024];
        VendorOrder: Code[30];
        PIH: Record "Purch. Inv. Header";
        VendorOrderCaption: Label 'Vendor Order No.';
        jci: Decimal;
        Amountr: Decimal;
        i: Integer;
        passed: Boolean;
        DocNo: Code[30];
}

