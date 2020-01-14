"""empty message

Revision ID: feb178e8a47a
Revises: eba6c363b5f2
Create Date: 2018-05-03 20:46:19.543050

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = 'feb178e8a47a'
down_revision = 'eba6c363b5f2'
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('countries', sa.Column('country_picture', postgresql.BYTEA(), nullable=True))
    op.add_column('countries', sa.Column('flag_picture', postgresql.BYTEA(), nullable=True))
    op.drop_column('countries', 'country_picture2')
    op.drop_column('countries', 'flag_picture2')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.add_column('countries', sa.Column('flag_picture2', postgresql.BYTEA(), autoincrement=False, nullable=True))
    op.add_column('countries', sa.Column('country_picture2', postgresql.BYTEA(), autoincrement=False, nullable=True))
    op.drop_column('countries', 'flag_picture')
    op.drop_column('countries', 'country_picture')
    # ### end Alembic commands ###
