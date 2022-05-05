tableextension 50110 SalesHeaderExtends extends "Sales Header"
{

    fields
    {
        //    VAT Base (retro.)
        field(50006; "VAT Date"; Date)
        {

            DataClassification = ToBeClassified;

        }
        field(50079; "Bin Checked"; Boolean)
        {
            DataClassification = ToBeClassified;

        }

        field(50007; "Internal Correction"; Boolean)
        {

            DataClassification = ToBeClassified;

        }
        field(50008; "Prepayment"; Boolean)
        {

            DataClassification = ToBeClassified;

        }

        field(50015; "Due Date 2"; Date)
        {

            DataClassification = ToBeClassified;

        }

        field(50016; "Due Date 3"; Date)
        {

            DataClassification = ToBeClassified;

        }


        field(50018; "Payment Terms Code 3"; Code[10])
        {

            trigger OnValidate();
            var
                PaymentTerms: Record "Payment Terms";
            begin

                IF ("Payment Terms Code 3" <> '') AND ("Document Date" <> 0D) THEN BEGIN
                    PaymentTerms.GET("Payment Terms Code 3");
                    IF (("Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"]) AND
                        NOT PaymentTerms."Calc. Pmt. Disc. on Cr. Memos")
                    THEN BEGIN
                        //INT1.00 start
                        VALIDATE("Due Date 3", "Document Date");
                        //INT1.00 end
                    END ELSE BEGIN
                        IF "Payment Terms Code 3" <> '' THEN
                            "Due Date 3" := CALCDATE(PaymentTerms."Due Date Calculation", "Due Date 2")
                        ELSE
                            "Due Date 3" := 0D;
                    END;
                END ELSE BEGIN
                    VALIDATE("Due Date", "Due Date");
                    IF "Payment Terms Code 3" <> '' THEN
                        VALIDATE("Due Date 3", "Due Date 3")
                    ELSE
                        VALIDATE("Due Date 3", 0D);
                END;
            end;
        }


        field(50017; "Payment Terms Code 2"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Payment Terms";
            trigger OnValidate();
            var
                PaymentTerms: Record "Payment Terms";
            begin

                IF ("Payment Terms Code 2" <> '') AND ("Document Date" <> 0D) THEN BEGIN
                    PaymentTerms.GET("Payment Terms Code 2");
                    IF (("Document Type" IN ["Document Type"::"Return Order", "Document Type"::"Credit Memo"]) AND
                        NOT PaymentTerms."Calc. Pmt. Disc. on Cr. Memos")
                    THEN BEGIN
                        //INT1.00 start
                        VALIDATE("Due Date 2", "Document Date");
                        //INT1.00 end
                    END ELSE BEGIN
                        IF "Payment Terms Code 2" <> '' THEN
                            "Due Date 2" := CALCDATE(PaymentTerms."Due Date Calculation", "Due Date")
                        ELSE
                            "Due Date 2" := 0D;
                    END;
                END ELSE BEGIN
                    VALIDATE("Due Date", "Due Date");
                    IF "Payment Terms Code 2" = '' THEN
                        VALIDATE("Due Date 2", 0D)
                    ELSE
                        VALIDATE("Due Date 2", "Due Date 2");
                END;


            end;
        }
        field(50019; "Group Member"; Boolean)
        {
            DataClassification = ToBeClassified;
        }

        field(50020; "Document Expiration Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(50026; "Total Value Letters"; Text[2])
        {
            Caption = 'Total Value Letters';
        }
        field(50027; "Country of Origin"; Code[20])
        {
            Caption = 'Country of Origin';
            TableRelation = "Country/Region";
        }
        field(50025; "Total Packaging"; Text[2])
        {
            Caption = 'Total Packaging';
        }
        field(50033; "Bank No."; Code[20])
        {
            TableRelation = "Bank Account"."No.";
        }
        field(50028; "Note 1"; Text[250])
        {
            Caption = 'Note 1';
        }
        field(50029; "Note 2"; Text[250])
        {
            Caption = 'Note 2';
        }
        field(50030; "Note 3"; Text[250])
        {
            Caption = 'Note 3';
        }
        modify("Sell-to Customer No.")
        {
            trigger OnAfterValidate()
            var
                TM2: Record Template_Message;
                TM: Record Template_Message;
                SalesSetup: Record "Sales & Receivables Setup";
                NoSeries: Record "No. Series Line";
            begin
                Commit();

                CompanyInfo.get;
                customer.Reset;
                customer.SetFilter("No.", '%1', "Sell-to Customer No.");
                if customer.FindFirst() then begin
                    if strpos(customer."Gen. Bus. Posting Group", 'INO') <> 0 then
                        "Note 1" := CompanyInfo."Note 1";
                    "Note 2" := CompanyInfo."Note 2";
                    Orderer := customer.Orderer;
                    "Order person" := customer."Order person";
                    "Responsible Person" := customer."Responsible Person";
                    "Contract Number" := customer."Contract Number";
                    Designer := customer.Designer;
                    "Project manager" := customer."Project manager";
                    "Responsible Person Infodom" := customer."Responsible Person Infodom";
                    "Message Code" := customer."Message Code";

                    if "Message Code" <> '' then begin
                        TM2.Reset();
                        TM2.SetFilter("Message Code", '%1', Rec."Message Code");
                        TM2.SetFilter(CustomerCOde, '%1', customer."No.");
                        // TemplateM2.SetFilter(Type, '%1', TemplateM2.Type::"Mail notification");
                        if TM2.FindFirst() then begin

                            TM.Init();
                            TM.TransferFields(TM2);
                            TM2.CalcFields("Message Text");
                            TM."Document No." := rec."No.";
                            TM.CustomerCOde := '';
                            TM."Message Text" := TM2."Message Text";


                            if Rec."No." = '' then begin
                                SalesSetup.Get();
                                NoSeries.Reset();
                                NoSeries.SetFilter("Series Code", '%1', SalesSetup."Order Nos.");
                                NoSeries.SetFilter("Starting Date", '<=%1', Today);
                                NoSeries.SetCurrentKey("Starting Date");
                                NoSeries.Ascending;
                                if NoSeries.FindLast() then begin
                                    TM."Document No." := IncStr(NoSeries."Last No. Used");
                                end;


                            end;
                            TM.Insert();
                        end;

                    end;
                end;

            end;
        }
        field(50031; "Orderer"; text[1000])
        {
            Caption = 'Orderer';
        }
        field(50032; "Contract Number"; Text[1000])
        {
            Caption = 'Contract Number';
        }
        field(50034; "Order person"; Text[1000])
        {
            Caption = 'Order person';
        }
        field(50035; "Responsible Person"; Text[1000])
        {
            Caption = 'Responsible Person';

        }
        field(50036; "Designer"; Text[1000])
        {
            Caption = 'Designer';
        }
        field(50037; "Project manager"; Text[1000])
        {
            Caption = 'Project manager';
        }
        field(50038; "HD Number"; Text[1000])
        {
            Caption = 'HD Number';
        }
        field(50039; "Area covered by changes"; Text[1000])
        {
            Caption = 'Area covered by changes';
        }
        field(50040; "Person/hours"; Text[1000])
        {
            Caption = 'Person/hours';
        }
        field(50041; "Amount without VAT"; Decimal)
        {
            Caption = 'Amount without VAT';
        }
        field(50042; "Deadline"; Text[1000])
        {
            Caption = 'Deadline';
        }
        field(50043; "seriousness"; Integer)
        {
            Caption = 'seriousness';
        }
        field(50044; "CR included"; Boolean)
        {
            Caption = 'CR';
        }
        field(50045; "Responsible Person Infodom"; Text[1000])
        {
            Caption = 'Responsible Person Infodom';
        }
        field(50046; "Templates for CR"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Templates for CR';
            CalcFormula = count(Template_Message where("Type" = FILTER(3 | 2), "Document No." = field("No.")));

        }
        field(50047; "Message Code"; Text[30])
        {
            TableRelation = Template_Message."Message Code" where("Type" = filter("Mail notification"), "Document No." = field("No."));
            Caption = 'Message Code';
        }
        field(50048; "Documents"; Integer)
        {
            FieldClass = FlowField;
            Caption = 'Documents';
            CalcFormula = count(Documents where("Document No" = field("No.")));
        }


    }

    trigger OnInsert()
    var
        myInt: Integer;
    begin
        "VAT Date" := Today;
        "Language Code" := 'HRV';
        CompanyInfo.get;


        /* "Note 1" := CompanyInfo."Note 1";
         "Note 2" := CompanyInfo."Note 2";*/


    end;


    /*  local  procedure InitRecord2()
    var
        ArchiveManagement: Codeunit "ArchiveManagement";
        IsHandled: Boolean;
          SalesSetup: Record "Sales & Receivables Setup";
          NoSeriesMgt: Codeunit "NoSeriesManagement";
          UserSetupMgt : Codeunit "User Setup Management";
          Cust: Record Customer;
          GLSetup: Record "General Ledger Setup";

    begin
   
        SalesSetup.GET;
        IsHandled := FALSE;
        OnBeforeInitRecord(Rec,IsHandled);
        IF NOT IsHandled THEN
          CASE "Document Type" OF
            "Document Type"::Quote,"Document Type"::Order:
              BEGIN
                NoSeriesMgt.SetDefaultSeries("Posting No. Series",SalesSetup."Posted Invoice Nos.");
                NoSeriesMgt.SetDefaultSeries("Shipping No. Series",SalesSetup."Posted Shipment Nos.");
                IF "Document Type" = "Document Type"::Order THEN BEGIN
                  NoSeriesMgt.SetDefaultSeries("Prepayment No. Series",SalesSetup."Posted Prepmt. Inv. Nos.");
                  NoSeriesMgt.SetDefaultSeries("Prepmt. Cr. Memo No. Series",SalesSetup."Posted Prepmt. Cr. Memo Nos.");
                END;
              END;
            "Document Type"::Invoice:
              BEGIN
                IF ("No. Series" <> '') AND
                   (SalesSetup."Invoice Nos." = SalesSetup."Posted Invoice Nos.")
                THEN
                  "Posting No. Series" := "No. Series"
                ELSE
                  NoSeriesMgt.SetDefaultSeries("Posting No. Series",SalesSetup."Posted Invoice Nos.");
                IF SalesSetup."Shipment on Invoice" THEN
                  NoSeriesMgt.SetDefaultSeries("Shipping No. Series",SalesSetup."Posted Shipment Nos.");
              END;
            "Document Type"::"Return Order":
              BEGIN
                NoSeriesMgt.SetDefaultSeries("Posting No. Series",SalesSetup."Posted Credit Memo Nos.");
                NoSeriesMgt.SetDefaultSeries("Return Receipt No. Series",SalesSetup."Posted Return Receipt Nos.");
              END;
            "Document Type"::"Credit Memo":
              BEGIN
                IF ("No. Series" <> '') AND
                   (SalesSetup."Credit Memo Nos." = SalesSetup."Posted Credit Memo Nos.")
                THEN
                  "Posting No. Series" := "No. Series"
                ELSE
                  NoSeriesMgt.SetDefaultSeries("Posting No. Series",SalesSetup."Posted Credit Memo Nos.");
                IF SalesSetup."Return Receipt on Credit Memo" THEN
                  NoSeriesMgt.SetDefaultSeries("Return Receipt No. Series",SalesSetup."Posted Return Receipt Nos.");
              END;
          END;

        IF "Document Type" IN ["Document Type"::Order,"Document Type"::Invoice,"Document Type"::Quote] THEN
          BEGIN
          "Shipment Date" := WORKDATE;
          "Order Date" := WORKDATE;
        END;
        IF "Document Type" = "Document Type"::"Return Order" THEN
          "Order Date" := WORKDATE;

        IF NOT ("Document Type" IN ["Document Type"::"Blanket Order","Document Type"::Quote]) AND
           ("Posting Date" = 0D)
        THEN
          "Posting Date" := WORKDATE;

        IF SalesSetup."Default Posting Date" = SalesSetup."Default Posting Date"::"No Date" THEN
          "Posting Date" := 0D;

        "Document Date" := WORKDATE;
        IF "Document Type" = "Document Type"::Quote THEN
          CalcQuoteValidUntilDate;

        VALIDATE("Location Code",UserSetupMgt.GetLocation(0,Cust."Location Code","Responsibility Center"));

        IF IsCreditDocType THEN BEGIN
          GLSetup.GET;
          Correction := GLSetup."Mark Cr. Memos as Corrections";
        END;

        "Posting Description" := FORMAT("Document Type") + ' ' + "No.";

        UpdateOutboundWhseHandlingTime;

        "Responsibility Center" := UserSetupMgt.GetRespCenter(0,"Responsibility Center");
        "Doc. No. Occurrence" := ArchiveManagement.GetNextOccurrenceNo(DATABASE::"Sales Header","Document Type","No.");

        OnAfterInitRecord(Rec);
    end;
    */
    var
        myInt: Integer;
        CompanyInfo: Record "Company Information";
        customer: Record Customer;


}