﻿using System;
using System.Collections.Generic;
using System.ComponentModel;
using System.Data;
using System.Drawing;
using System.Linq;
using System.Text;
using System.Windows.Forms;

namespace AceSoft.RetailPlus.Client.UI
{
    public partial class NoControl : Form
    {
        public DialogResult Result { get; set; }
        public decimal NoValue { get; set; }
        public string Caption { get; set; }

        #region Form Methods

        public NoControl()
        {
            InitializeComponent();
        }

        #endregion

        #region Control Methods

        private void NoControl_Load(object sender, EventArgs e)
        {
            this.Result = System.Windows.Forms.DialogResult.Cancel;

            if (!string.IsNullOrEmpty(Caption))
            {
                try
                { this.BackgroundImage = new Bitmap(Application.StartupPath + "/images/Background.jpg"); }
                catch { }
                this.ControlBox = true;
                this.Text  = Caption;
                if ((NoValue - decimal.Round(NoValue)) > decimal.Parse("0.001"))
                    txtNo.Text = NoValue.ToString("#,##0.#0");
                else
                    txtNo.Text = NoValue.ToString("#,##0");

                txtNo.SelectAll();
            }
        }

        private void NoControl_KeyDown(object sender, System.Windows.Forms.KeyEventArgs e)
        {
            switch (e.KeyData)
            {
                case Keys.Escape:
                    this.Result = DialogResult.Cancel;
                    this.Hide();
                    break;

                case Keys.Enter:
                    if (isValuesAssigned())
                    {
                        this.Result = DialogResult.OK;
                        this.Hide();
                    }
                    break;
            }
        }

        private void keyboardNoControl1_UserKeyPressed(object sender, AceSoft.KeyBoardHook.KeyboardEventArgs e)
        {
            txtNo.Focus();
            if (e.KeyboardKeyPressed == "{CLEAR}")
                txtNo.Text = "";
            else if (e.KeyboardKeyPressed == "{SELECTALL}")
                txtNo.SelectAll();
            else
                SendKeys.Send(e.KeyboardKeyPressed);
        }

        #endregion

        #region Private Methods

        private bool isValuesAssigned()
        {
            decimal decRetValue = 0;

            if (!decimal.TryParse(txtNo.Text, out decRetValue))
            {
                MessageBox.Show("Sorry an invalid no was has been detected.", "RetailPlus", MessageBoxButtons.OK, MessageBoxIcon.Information);
                txtNo.SelectAll();
                return false;
            }
            else { NoValue = decRetValue; }
            return true;
        }

        private void SetPressButton(string strKey)
        {
            txtNo.Text += strKey;
        }

        #endregion

    }
}