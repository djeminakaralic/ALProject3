report 50072 "PDV prijava"
{
    DefaultLayout = RDLC;
    RDLCLayout = './PDV prijava.rdl';

    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;


    dataset
    {
        dataitem(DataItem1; "VAT Entry")
        {
            column(Amount_VATEntry; Amount)
            {
            }
            column(Type_VATEntry; Type)
            {
            }
            column(Base_VATEntry; Base)
            {
            }
            column(VATBaseretro_VATEntry; "VAT Base (retro.)")
            {
            }
            column(VATBusPostingGroup_VATEntry; "VAT Bus. Posting Group")
            {
            }
            column(VATProdPostingGroup_VATEntry; "VAT Prod. Posting Group")
            {
            }
            column(VATCalculationType_VATEntry; "VAT Calculation Type")
            {
            }
            column(s22; s22)
            {
            }
            column(s42; s42)
            {
            }
            column(s12; s12)
            {
            }
            column(s11; s11)
            {
            }
            column(s21; s21)
            {
            }
            column(s41; s41)
            {
            }
            column(s61; s61)
            {
            }
            column(s71; s71)
            {
            }
            column(s51; s51)
            {
            }
            column(stot; stot)
            {
            }
            column(s13; s13)
            {
            }
            column(fbih; fbih)
            {
            }
            column(rs; rs)
            {
            }
            column(db; db)
            {
            }
            column(fullvat; fullvat)
            {
            }
            column(fullvat2; fullvat2)
            {
            }
            column(s71positive; s71positive)
            {
            }
            column(StartDate; StartDate)
            {
            }
            column(EndDate; EndDate)
            {
            }
            column(DeliverDate; DeliverDate)
            {
            }
            column(RequestForRefund; "Request for Refund")
            {
            }
            dataitem(DataItem17; "Company Information")
            {
                column(Name_CompanyInformation; Name)
                {
                }
                column(Address_CompanyInformation; Address)
                {
                }
                column(PostCode_CompanyInformation; "Post Code")
                {
                }
                column(City_CompanyInformation; City)
                {
                }
                column(VATRegistrationNo_CompanyInformation; "VAT Registration No.")
                {
                }
            }

            trigger OnAfterGetRecord()
            var
                ve: Record "VAT Entry";
                ve2: Record "VAT Entry";
                ve3: Record "VAT Entry";
                ve4: Record "VAT Entry";
                ve5: Record "VAT Entry";
                ve6: Record "VAT Entry";
                ve7: Record "VAT Entry";
                ve8: Record "VAT Entry";
                ve9: Record "VAT Entry";
                ve10: Record "VAT Entry";
                ve11: Record "VAT Entry";
                ve12: Record "VAT Entry";
                ve13: Record "VAT Entry";
                ve14: Record "VAT Entry";
                ve15: Record "VAT Entry";
                ve16: Record "VAT Entry";
                ve17: Record "VAT Entry";
                ve19: Record "VAT Entry";
                ve20: Record "VAT Entry";
                ve21: Record "VAT Entry";
                ve22: Record "VAT Entry";
                ve23: Record "VAT Entry";
                ve24: Record "VAT Entry";
                ve51: Record "VAT Entry";
                ve26: Record "VAT Entry";
            begin


                ve.SETRANGE("VAT Date", StartDate, EndDate);
                //ve.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                ve.SETFILTER(Import, '%1', FALSE);
                //ve.SETFILTER("VAT Prod. Posting Group",'<>%1','VATCUST');
                //ve.SETFILTER("VAT Prod. Posting Group",'<>%1','VATCUS');
                //ve.SETFILTER("VAT Prod. Posting Group",'<>%1','ONLYCBC');
                ve.SETFILTER(Type, '%1', ve.Type::Purchase);
                IF ve.FIND('-')
                 THEN
                    REPEAT
                        ve.CALCFIELDS("Total Entry No.");
                        ve.CALCFIELDS("Full VAT");
                        //IF ve."Total Entry No."<>0 THEN
                        //   s21 :=s21+ve.Base+(ve."Full VAT"/ve."Total Entry No.")-ve."VAT Amount (retro.)"
                        IF ve."VAT Prod. Posting Group" = 'PDV NEPOT' THEN
                            s211 := s211 + ve.Base - ve."VAT Amount (retro.)"
                        ELSE
                            s211 := s211 + ve.Base;
                    // ELSE

                    //   s21 :=s21+ve.Base-ve."VAT Amount (retro.)";
                    UNTIL ve.NEXT = 0;
                s21 := ROUND(s211, 1, '<');

                ve2.SETRANGE("VAT Date", StartDate, EndDate);
                //ve2.SETFILTER("Gen. Bus. Posting Group",'%1','INO');
                ve2.SETFILTER(Import, '%1', TRUE);
                ve2.SETFILTER("VAT Calculation Type", '%1', 2);
                ve2.SETFILTER(Type, '%1', ve2.Type::Purchase);
                IF ve2.FIND('-')
                 THEN
                    REPEAT
                        s221 := s221 + ve2."VAT Base (retro.)";
                    UNTIL ve2.NEXT = 0;
                s22 := ROUND(s221, 1, '<');

                ve3.SETRANGE("VAT Date", StartDate, EndDate);
                //ve3.SETFILTER("VAT. Prod. Posting Group",'%1','FOREIGN');
                ve3.SETFILTER("VAT Prod. Posting Group", '<>%1', 'PUNI NEPOT');

                ve3.SETFILTER(Import, '%1', TRUE);
                ve3.SETFILTER(Type, '%1', ve3.Type::Purchase);
                IF ve3.FIND('-')
                 THEN
                    REPEAT
                        s421 := s421 + ve3.Amount;
                    UNTIL ve3.NEXT = 0;
                s42 := ROUND(s421, 1, '<');
                /*
                ve9.SETRANGE("VAT Date", StartDate,EndDate);
                ve9.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                ve9.SETFILTER("VAT. Prod. Posting Group",'<>%1','FULLVATCBC');
                ve9.SETFILTER(Type,'%1',ve9.Type::Purchase);
                ve9.SETFILTER("VAT Calculation Type",'%1',2);
                IF ve9.FIND('-')
                 THEN REPEAT
                   fullvat :=fullvat+ve9.Amount;
                UNTIL ve9.NEXT=0;     */

                ve4.SETRANGE("VAT Date", StartDate, EndDate);
                //ve4.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                //ve4.SETFILTER("VAT Bus. Posting Group",'%1','V-17-VAT');
                //ve4.SETFILTER("VAT Calculation Type",'<>%1',2);
                ve4.SETFILTER(Import, '%1', FALSE);
                //ve4.SETFILTER("VAT Prod. Posting Group",'<>%1','VATCUST');
                ve4.SETFILTER("VAT Prod. Posting Group", '<>%1', 'SAMO PDV');
                ve4.SETFILTER(Type, '%1', ve4.Type::Purchase);
                IF ve4.FIND('-')
                 THEN
                    REPEAT
                        s411 := s411 + ve4.Amount;
                    UNTIL ve4.NEXT = 0;
                s41 := ROUND(s411, 1, '<');

                ve5.SETRANGE("VAT Date", StartDate, EndDate);
                ve5.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                ve5.SETFILTER(Type, '%1', ve5.Type::Sale);
                IF ve5.FIND('-')
                 THEN
                    REPEAT
                        s111 := s111 + ve5.Base;
                    UNTIL ve5.NEXT = 0;


                ve51.SETRANGE("VAT Date", StartDate, EndDate);
                ve51.SETFILTER("Gen. Bus. Posting Group", '%1', 'INO');
                ve51.SETFILTER("Gen. Prod. Posting Group", '%1', 'USL-PDV');
                ve51.SETFILTER("VAT Prod. Posting Group", '<>%1', 'OSL-PDV');
                ve51.SETFILTER(Type, '%1', ve51.Type::Sale);
                IF ve51.FIND('-')
                 THEN
                    REPEAT
                        s1111 := s1111 + ve51.Base;
                    UNTIL ve51.NEXT = 0;
                s11 := ROUND(s111, 1, '<') + ROUND(s1111, 1, '<');

                ve6.SETRANGE("VAT Date", StartDate, EndDate);
                ve6.SETFILTER("Gen. Bus. Posting Group", '%1', 'INO');
                //ve6.SETFILTER("Gen. Prod. Posting Group",'<>%1&<>%2','USL-PDV','USL');
                ve6.SETFILTER("VAT Prod. Posting Group", '<>%1', 'OSL-PDV');
                ve6.SETFILTER(Type, '%1', ve6.Type::Sale);
                IF ve6.FIND('-')
                 THEN
                    REPEAT
                        s121 := s121 + ve6.Base;
                    UNTIL ve6.NEXT = 0;
                s12 := ROUND(s121, 1, '<');

                ve7.SETRANGE("VAT Date", StartDate, EndDate);
                //ve7.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                ve7.SETFILTER(Type, '%1', ve7.Type::Sale);
                IF ve7.FIND('-')
                 THEN
                    REPEAT
                        s511 := s511 + ve7.Amount;
                    UNTIL ve7.NEXT = 0;



                ve8.SETRANGE("VAT Date", StartDate, EndDate);
                //ve7.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                ve8.SETFILTER("VAT Calculation Type", '%1', ve8."VAT Calculation Type"::"Reverse Charge VAT");
                IF ve8.FIND('-')
                 THEN
                    REPEAT
                        s511 += -ve8.Amount;
                    UNTIL ve8.NEXT = 0;

                s51 := ROUND(s511, 1, '<');

                ve10.SETRANGE("VAT Date", StartDate, EndDate);
                ve10.SETFILTER("Customer Entity Code", '%1|%2', 'FBIH', '');
                ve10.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                ve10.SETFILTER("VAT Bus. Posting Group", '%1', 'K-0-PDV');

                ve10.SETFILTER(Type, '%1', ve10.Type::Sale);
                IF ve10.FIND('-')
                 THEN
                    REPEAT
                        c0 := c0 + ve10.Amount;
                    UNTIL ve10.NEXT = 0;

                ve17.SETRANGE("VAT Date", StartDate, EndDate);
                ve17.SETFILTER("Customer Entity Code", '%1|%2', 'FBIH', '');
                ve17.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                ve17.SETFILTER("VAT Bus. Posting Group", '%1', 'D-0-PDV');

                ve17.SETFILTER(Type, '%1', ve17.Type::Purchase);
                IF ve17.FIND('-')
                 THEN
                    REPEAT
                        c8 := c8 + ve17.Amount;
                    UNTIL ve17.NEXT = 0;


                ve11.SETRANGE("VAT Date", StartDate, EndDate);
                //ve11.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                ve11.SETFILTER("VAT Prod. Posting Group", '%1', 'PDV MANJAK');

                ve11.SETFILTER(Type, '%1', ve11.Type::Sale);
                IF ve11.FIND('-')
                 THEN
                    REPEAT
                        c1 := c1 + ABS(ve11.Amount);
                    UNTIL ve11.NEXT = 0;


                ve12.SETRANGE("VAT Date", StartDate, EndDate);
                //ve12.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                ve12.SETFILTER("Vendor Entity Code", '%1|%2', 'FBIH', '');
                ve12.SETFILTER("VAT Prod. Posting Group", '%1', 'PDV NEPOT');
                ve12.SETFILTER("VAT Bus. Posting Group", '<>%1', 'D-INO');
                //ve12.SETFILTER(Type,'%1',ve11.Type::Sale);
                IF ve12.FIND('-')
                 THEN
                    REPEAT
                        c2 := c2 + ve12."VAT Amount (retro.)";
                    UNTIL ve12.NEXT = 0;


                ve19.SETRANGE("VAT Date", StartDate, EndDate);
                //NK ve19.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                ve19.SETFILTER("Vendor Entity Code", '%1|%2', 'FBIH', '');
                ve19.SETFILTER(Type, '%1', ve9.Type::Purchase);
                ve19.SETFILTER("VAT Calculation Type", '%1', 2);
                ve19.SETFILTER("VAT Prod. Posting Group", '%1', 'PUNI NEPOT');
                IF ve19.FIND('-')
                 THEN
                    REPEAT
                        fullvat2 := fullvat2 + ve19."VAT Amount (retro.)";
                    UNTIL ve19.NEXT = 0;

                ve24.SETRANGE("VAT Date", StartDate, EndDate);
                //ve11.SETFILTER("Gen. Bus. Posting Group",'%1','DOMAĆI');
                ve24.SETFILTER("VAT Prod. Posting Group", '%1', 'SAMO PDV');

                ve24.SETFILTER(Type, '%1', ve24.Type::Purchase);
                IF ve24.FIND('-')
                 THEN
                    REPEAT
                        c20 := c20 + ABS(ve24.Amount);
                    UNTIL ve24.NEXT = 0;


                fbih := ROUND(c0 + c1 + c2 + c8 + fullvat2 + c20, 1, '<');

                ve13.SETRANGE("VAT Date", StartDate, EndDate);
                ve13.SETFILTER("Customer Entity Code", '%1', 'RS');
                ve13.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                ve13.SETFILTER("VAT Bus. Posting Group", '%1', 'K-0-PDV');

                ve13.SETFILTER(Type, '%1', ve13.Type::Sale);
                IF ve13.FIND('-')
                 THEN
                    REPEAT
                        c3 := c3 + ve13.Amount;
                    UNTIL ve13.NEXT = 0;


                ve20.SETRANGE("VAT Date", StartDate, EndDate);
                ve20.SETFILTER("Customer Entity Code", '%1', 'RS');
                ve20.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                ve20.SETFILTER("VAT Bus. Posting Group", '%1', 'D-0-PDV');

                ve20.SETFILTER(Type, '%1', ve20.Type::Purchase);
                IF ve20.FIND('-')

                THEN
                    REPEAT
                        c7 := c7 + ve20.Amount;
                    UNTIL ve20.NEXT = 0;

                ve21.SETRANGE("VAT Date", StartDate, EndDate);
                ve21.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                ve21.SETFILTER("Vendor Entity Code", '%1', 'RS');
                ve21.SETFILTER(Type, '%1', ve21.Type::Purchase);
                ve21.SETFILTER("VAT Calculation Type", '%1', 2);
                ve21.SETFILTER("VAT Prod. Posting Group", '%1', 'PUNI NEPOT');
                IF ve21.FIND('-')
                 THEN
                    REPEAT
                        fullvat2rs := fullvat2rs + ve21."VAT Amount (retro.)";
                    UNTIL ve21.NEXT = 0;


                ve14.SETRANGE("VAT Date", StartDate, EndDate);
                ve12.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                ve14.SETFILTER("Vendor Entity Code", '%1', 'RS');
                ve14.SETFILTER("VAT Bus. Posting Group", '<>%1', 'D-INO');
                ve14.SETFILTER("VAT Prod. Posting Group", '%1', 'PDV NEPOT');

                ve12.SETFILTER(Type, '%1', ve11.Type::Sale);
                IF ve14.FIND('-')
                 THEN
                    REPEAT
                        c4 := c4 + ve14."VAT Amount (retro.)";
                    UNTIL ve14.NEXT = 0;
                rs := ROUND(c3 + c4 + c7 + fullvat2rs, 1, '<');

                ve15.SETRANGE("VAT Date", StartDate, EndDate);
                ve15.SETFILTER("Customer Entity Code", '%1', 'DB');
                ve15.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                ve15.SETFILTER("VAT Bus. Posting Group", '%1', 'K-0-PDV');

                ve15.SETFILTER(Type, '%1', ve15.Type::Sale);
                IF ve15.FIND('-')
                 THEN
                    REPEAT
                        c5 := c5 + ve15.Amount;
                    UNTIL ve15.NEXT = 0;




                ve16.SETRANGE("VAT Date", StartDate, EndDate);
                ve12.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                ve16.SETFILTER("Vendor Entity Code", '%1', 'DB');
                ve16.SETFILTER("VAT Bus. Posting Group", '<>%1', 'D-INO');
                ve16.SETFILTER("VAT Prod. Posting Group", '%1', 'PDV NEPOT');

                //ve12.SETFILTER(Type,'%1',ve11.Type::Sale);
                IF ve16.FIND('-')
                 THEN
                    REPEAT
                        c6 := c6 + ve16."VAT Amount (retro.)";
                    UNTIL ve16.NEXT = 0;

                ve22.SETRANGE("VAT Date", StartDate, EndDate);
                ve22.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                ve22.SETFILTER("Vendor Entity Code", '%1', 'DB');
                ve22.SETFILTER(Type, '%1', ve22.Type::Purchase);
                ve22.SETFILTER("VAT Calculation Type", '%1', 2);
                ve22.SETFILTER("VAT Prod. Posting Group", '%1', 'PUNI NEPOT');
                IF ve22.FIND('-')
                 THEN
                    REPEAT
                        fullvat2db := fullvat2db + ve22."VAT Amount (retro.)";
                    UNTIL ve22.NEXT = 0;

                ve23.SETRANGE("VAT Date", StartDate, EndDate);
                ve23.SETFILTER("Customer Entity Code", '%1', 'DB');
                ve23.SETFILTER("Gen. Bus. Posting Group", '%1', 'DOMAĆI');
                ve23.SETFILTER("VAT Bus. Posting Group", '%1', 'D-0-PDV');

                ve23.SETFILTER(Type, '%1', ve23.Type::Purchase);
                IF ve23.FIND('-')

                THEN
                    REPEAT
                        c9 := c9 + ve23.Amount;
                    UNTIL ve23.NEXT = 0;


                ve26.SETRANGE("VAT Date", StartDate, EndDate);
                //ve26.SETFILTER("Gen. Bus. Posting Group",'%1','INO');
                ve26.SETFILTER("VAT Prod. Posting Group", '%1', 'OSL-PDV');
                ve26.SETFILTER(Type, '%1', ve26.Type::Sale);
                IF ve26.FIND('-')
                 THEN
                    REPEAT
                        s131 := s131 + ve26.Base;
                    UNTIL ve26.NEXT = 0;
                s13 := ROUND(s131, 1, '<');


                db := ROUND(c5 + c6 + c9 + fullvat2db, 1, '<');

            end;

            trigger OnPreDataItem()
            begin
                //ĐK  SETFILTER("Document Type", '<>%1', "Document Type"::"Finance Charge Memo");
                SETRANGE("VAT Date", StartDate, EndDate);

                DeliverDate := EndDate + 10;
                s21 := 0;
                s211 := 0;
                s22 := 0;
                s221 := 0;
                s42 := 0;
                s421 := 0;
                s41 := 0;
                s51 := 0;
                s511 := 0;
                s11 := 0;
                s111 := 0;
                s12 := 0;
                s121 := 0;
                s131 := 0;
                s13 := 0;
                c0 := 0;
                c1 := 0;
                c2 := 0;
                fbih := 0;
                c3 := 0;
                c4 := 0;
                rs := 0;
                c5 := 0;
                c6 := 0;
                db := 0;
                s13 := 0;
            end;
        }
    }

    requestpage
    {

        layout
        {
            area(content)
            {
                group("VAT period")
                {
                    Caption = 'VAT period';
                    field(StartDate; StartDate)
                    {
                        Caption = 'Start Date';
                    }
                    field(EndDate; EndDate)
                    {
                        Caption = 'End Date';
                    }
                    field("Request for Refund"; "Request for Refund")
                    {
                        Caption = 'Request for Refund';
                    }
                }
            }
        }

        actions
        {
        }
    }

    labels
    {
    }

    var
        s131: Decimal;
        s13: Decimal;
        s12: Decimal;
        s111: Decimal;
        s1111: Decimal;
        s121: Decimal;
        s21: Decimal;
        s211: Decimal;
        s22: Decimal;
        s221: Decimal;
        s41: Decimal;
        s411: Decimal;
        s42: Decimal;
        s421: Decimal;
        s61: Decimal;
        s71: Decimal;
        s71positive: Decimal;
        VatEntry: Record "VAT Entry";
        type: Option;
        StartDate: Date;
        EndDate: Date;
        DeliverDate: Date;
        "Request for Refund": Boolean;
        s51: Decimal;
        s511: Decimal;
        stot: Decimal;
        s11: Decimal;
        rv: Decimal;
        fullvat: Decimal;
        c0: Decimal;
        c1: Decimal;
        c2: Decimal;
        fbih: Decimal;
        c3: Decimal;
        c4: Decimal;
        rs: Decimal;
        c5: Decimal;
        c6: Decimal;
        db: Decimal;
        c8: Decimal;
        fullvat2: Decimal;
        vatcbc: Decimal;
        c7: Decimal;
        fullvat2rs: Decimal;
        fullvat2db: Decimal;
        c9: Decimal;
        c20: Decimal;
}

