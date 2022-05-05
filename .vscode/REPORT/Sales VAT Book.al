report 50021 "Sales VAT Book"
{
    // BH1.00, VAT Books
    DefaultLayout = RDLC;
    RDLCLayout = './Sales VAT Book.rdl';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;

    Caption = 'Sales VAT Book report';
    dataset
    {
        dataitem(DataItem1; "VAT Entry")
        {
            DataItemTableView = SORTING("Posting Date", "Document No.")
                                ORDER(Ascending);
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
            column(PostingDate; "Posting Date")
            {
                IncludeCaption = true;
            }
            column(CustomerName; Customer.Name + ', ' + Customer.City)
            {
            }
            column(VATRegistrationNo; "VAT Registration No.")
            {
                IncludeCaption = true;
            }
            column(CounterCaption; CounterCaption)
            {
            }
            column(CustomerCaption; VendorCaption)
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
            column(HeaderCustomerCaption; HeaderCustomerCaption)
            {
            }
            column(HeaderVATCaption; HeaderVATCaption)
            {
            }
            column(TotalCaption; TotalCaption)
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

                end;
            }

            trigger OnAfterGetRecord()
            begin
                IF (Type = Type::Purchase) AND ("VAT Calculation Type" = "VAT Calculation Type"::"Reverse Charge VAT")
                THEN
                    Type := Type::Sale;


                IF Type <> Type::Sale THEN
                    CurrReport.SKIP;

                IF NOT Customer.GET("Bill-to/Pay-to No.") THEN BEGIN
                    //Customer.INIT;
                    //Customer.Name := CompInfo.Name;
                    //"VAT Registration No." := CompInfo."VAT Registration No.";
                    Vendor.GET("Bill-to/Pay-to No.");
                    Customer.INIT;
                    Customer.Name := Vendor.Name;
                    "VAT Registration No." := Vendor."VAT Registration No.";

                END;
            end;

            trigger OnPreDataItem()
            begin
                SETFILTER("Document Type", '<>%1', "Document Type"::"Finance Charge Memo");
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
        Customer: Record Customer;
        ReportCaption: Label 'Sales VAT Book';
        PageNoCaptionLbl: Label 'Page';
        CounterCaption: Label 'No.';
        VendorCaption: Label 'Name, City';
        Column1Caption: Label 'Amount incl. VAT';
        Column2Caption: Label 'Internal invoices';
        Column3Caption: Label 'Export';
        Column4Caption: Label 'Other';
        Column5Caption: Label 'VAT Base for VAT obligators';
        Column6Caption: Label 'VAT Amount for all invoices';
        HeaderDocumentCaption: Label 'Document';
        HeaderCustomerCaption: Label 'Customer';
        HeaderVATCaption: Label 'VAT';
        TotalCaption: Label 'Total';
        ReportFilters: Text[1024];
        Vendor: Record Vendor;
}

